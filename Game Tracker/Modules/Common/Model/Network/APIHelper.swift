//
//  APIHelper.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Alamofire

typealias RemoteDTO = Decodable & Sendable

private struct APISuccessResponse<T: RemoteDTO>: RemoteDTO {
    let success: Int
    let result: [T]
}

private let API_BASE = URL(string: "https://apiv2.allsportsapi.com")!

class APIHelper {
    enum Kind: String {
        case Leagues = "Leagues"
        case Events = "Fixtures"
        case Teams = "Teams"
    }
    
    static func fetch<T>(sport: Sport, kind: Kind, arguments: [String: String], completionHandler: @escaping (Result<[T], Error>) -> Void) where T: RemoteDTO {
        let sportString = switch sport {
            case .football:
                "football"
            case .basketball:
                "basketball"
            case .cricket:
                "cricket"
            case .tennis:
                "tennis"
        }
        
        var params = arguments.map { URLQueryItem(name: $0, value: $1) }
        params.append(URLQueryItem(name: "APIkey", value: SPORTS_API_KEY))
        
        let url = API_BASE.appending(path: sportString).appending(queryItems: params)
        
        AF.request(url).responseDecodable(of: APISuccessResponse<T>.self) { res in
            switch res.result {
                case .success(let result):
                    completionHandler(Result.success(result.result as [T]))
                    
                case .failure(let error):
                    completionHandler(Result.failure(error))
            }
        }
    }
}
