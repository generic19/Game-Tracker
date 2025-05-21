//
//  APIHelper.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Alamofire

private struct APISuccessResponse<T: RemoteDTO>: Decodable & Sendable {
    let success: Int
    let result: [T]?
}

private let API_BASE = URL(string: "https://apiv2.allsportsapi.com")!.with(params: [
    "APIkey": SPORTS_API_KEY
])

private let dateFormatter = DateFormatter.standardDate()

class AlamofireSportsAPIService: SportsAPIService {
    
    func fetchLeagues<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport
    ) -> Result<[any ModelConvertible], Error> {
        let url = API_BASE.with(path: sport.rawValue, params: [
            "met": "Leagues"
        ])
        
        return fetch(as: type, url: url)
    }
    
    func fetchEvents<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
        from startDate: Date,
        to endDate: Date
    ) -> Result<[any ModelConvertible], Error> {
        let url = API_BASE.with(path: sport.rawValue, params: [
            "met": "Fixtures",
            "from": dateFormatter.string(from: startDate),
            "to": dateFormatter.string(from: endDate),
            "timezone": "UTC",
            "leagueId": "\(leagueId)",
        ])
        
        return fetch(as: type, url: url)
    }
    
    func fetchTeams<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int
    ) -> Result<[any ModelConvertible], Error> {
        let url = API_BASE.with(path: sport.rawValue, params: [
            "met": "Teams",
            "leagueId": "\(leagueId)",
        ])
        
        return fetch(as: type, url: url)
    }
    
    private func fetch<T: RemoteDTO>(as type: T.Type, url: URL) -> Result<[any ModelConvertible], Error> {
        var fetchResult: Result<[any ModelConvertible], Error>!
        let semaphore = DispatchSemaphore(value: 0)
        
        AF.request(url).responseDecodable(of: APISuccessResponse<T>.self) { response in
            switch response.result {
                case .success(let response):
                    fetchResult = .success(response.result ?? [])
                    
                case .failure(let error):
                    let error = error.asAFError?.underlyingError ?? error
                    fetchResult = .failure(error)
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return fetchResult
    }
}
