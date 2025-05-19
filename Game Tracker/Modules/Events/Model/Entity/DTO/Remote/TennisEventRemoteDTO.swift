//
//  TennisEventRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

private let dateTimeFormatter = DateFormatter.standardDateTime()

struct TennisEventRemoteDTO: RemoteDTO {
    let id: Int
    let date: String
    let time: String
    let firstPlayerName: String
    let firstPlayerImage: String?
    let secondPlayerName: String
    let secondPlayerImage: String?
    let result: String?

    enum CodingKeys: String, CodingKey {
        case id = "event_key"
        case date = "event_date"
        case time = "event_time"
        case firstPlayerName = "event_first_player"
        case firstPlayerImage = "event_first_player_logo"
        case secondPlayerName = "event_second_player"
        case secondPlayerImage = "event_second_player_logo"
        case result = "event_final_result"
    }

    func toModel() -> Event {
        let dateTime = dateTimeFormatter.date(from: "\(date) \(time)")
        let firstImageURL: URL? = firstPlayerImage?.hasSuffix("/") == false ? URL(string: firstPlayerImage!) : nil
        let secondImageURL: URL? = secondPlayerImage?.hasSuffix("/") == false ? URL(string: secondPlayerImage!) : nil

        return Event(
            id: id,
            datetime: dateTime,
            firstParticipant: .player(
                Person(
                    name: firstPlayerName,
                    image: firstImageURL,
                    role: nil
                )
            ),
            secondParticipant: .player(
                Person(
                    name: secondPlayerName,
                    image: secondImageURL,
                    role: nil
                )
            ),
            result: result
        )
    }
}
