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

private let API_BASE = URL(string: "https://apiv2.allsportsapi.com")!
    .appending(queryItems: [URLQueryItem(name: "APIkey", value: SPORTS_API_KEY)])

private let dateFormatter = DateFormatter.isoDate()

class AlamofireSportsAPIService: SportsAPIService {
    func fetchLeagues<T: RemoteDTO>(as type: T.Type, sport: Sport, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        let url = API_BASE
            .appending(component: sport.rawValue)
            .appending(queryItems: [
                URLQueryItem(name: "met", value: "Leagues"),
            ])
        
        fetch(as: type, url: url, completionHandler: completionHandler)
    }
    
    func fetchEvents<T: RemoteDTO>(as type: T.Type, sport: Sport, leagueId: Int, from startDate: Date, to endDate: Date, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        let url = API_BASE
            .appending(component: sport.rawValue)
            .appending(queryItems: [
                URLQueryItem(name: "met", value: "Fixtures"),
                URLQueryItem(name: "from", value: dateFormatter.string(from: startDate)),
                URLQueryItem(name: "to", value: dateFormatter.string(from: startDate)),
                URLQueryItem(name: "timezone", value: "UTC"),
                URLQueryItem(name: "leagueId", value: "\(leagueId)"),
            ])
        
        fetch(as: type, url: url, completionHandler: completionHandler)
    }
    
    func fetchTeams<T: RemoteDTO>(as type: T.Type, sport: Sport, leagueId: Int, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        let url = API_BASE
            .appending(component: sport.rawValue)
            .appending(queryItems: [
                URLQueryItem(name: "met", value: "Teams"),
                URLQueryItem(name: "leagueId", value: "\(leagueId)"),
            ])
        
        fetch(as: type, url: url, completionHandler: completionHandler)
    }
    
    func fetchTeam<T: RemoteDTO>(as type: T.Type, sport: Sport, teamId: Int, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        let url = API_BASE
            .appending(component: sport.rawValue)
            .appending(queryItems: [
                URLQueryItem(name: "met", value: "Teams"),
                URLQueryItem(name: "teamId", value: "\(teamId)"),
            ])
        
        fetch(as: type, url: url, completionHandler: completionHandler)
    }
    
    private func fetch<T: RemoteDTO>(as type: T.Type, url: URL, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        AF.request(url).responseDecodable(of: APISuccessResponse<T>.self) { response in
            switch response.result {
                case .success(let result):
                    completionHandler(Result.success(result.result))
                    
                case .failure(let error):
                    completionHandler(Result.failure(error))
            }
        }
    }
}

extension DateFormatter {
    static func isoDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

