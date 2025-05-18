//
//  APIHelper.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Alamofire

typealias RemoteDTO = Decodable & Sendable & ModelConvertible

private struct APISuccessResponse<T: RemoteDTO>: Decodable & Sendable {
    let success: Int
    let result: [T]
}

private let API_BASE = URL(string: "https://apiv2.allsportsapi.com")!.with(params: [
    "APIkey": SPORTS_API_KEY
])

private let dateFormatter = DateFormatter.isoDate()

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
            "to": dateFormatter.string(from: startDate),
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
    
    func fetchTeam<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        teamId: Int
    ) -> Result<[any ModelConvertible], Error> {
        let url = API_BASE.with(path: sport.rawValue, params: [
            "met": "Teams",
            "teamId": "\(teamId)",
        ])
        
        return fetch(as: type, url: url)
    }
    
    private func fetch<T: RemoteDTO>(as type: T.Type, url: URL) -> Result<[any ModelConvertible], Error> {
        var fetchResult: Result<[any ModelConvertible], Error>!
        let semaphore = DispatchSemaphore(value: 0)
        
        AF.request(url).responseDecodable(of: APISuccessResponse<T>.self) { response in
            switch response.result {
                case .success(let response):
                    fetchResult = .success(response.result)
                    
                case .failure(let error):
                    fetchResult = .failure(error)
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return fetchResult
    }
}

extension DateFormatter {
    static func isoDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

extension URL {
    func with(path: String? = nil, params: [String: String]) -> URL {
        let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var url = self.appending(queryItems: queryItems)
        if let path = path {
            url = url.appending(path: path)
        }
        
        return url
    }
}
