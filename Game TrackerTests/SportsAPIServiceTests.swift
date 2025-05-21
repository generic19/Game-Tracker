//
//  SportsAPIServiceTests.swift
//  Game TrackerTests
//
//  Created by Basel Alasadi on 09/05/2025.
//

import XCTest
@testable import Game_Tracker

final class SportsAPIServiceTests: XCTestCase {
    
    func testOffline() {
        let fakeService = FakeSportsAPIService(isConnected: false)
        
        let result = fakeService.fetchLeagues(as: FootballLeagueRemoteDTO.self, sport: .football)
        switch result {
        case .failure(let error):
            XCTAssertEqual(error as? FakeNetworkError, .notConnected)
        case .success:
            XCTFail("Must fail if offline.")
        }
    }

    func testOnline() {
        let fakeService = FakeSportsAPIService(isConnected: true)
        let result = fakeService.fetchTeams(as: FootballTeamRemoteDTO.self, sport: .football, leagueId: 1)
        
        switch result {
        case .success(let models):
            XCTAssertTrue(models.isEmpty)
                
        case .failure(let error):
            XCTFail("Must return success when online, instead got \(error)")
        }
    }
}

enum FakeNetworkError: Error {
    case notConnected
}

class FakeSportsAPIService: SportsAPIService {
    let isConnected: Bool

    init(isConnected: Bool = true) {
        self.isConnected = isConnected
    }

    func fetchLeagues<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport
    ) -> Result<[any ModelConvertible], Error> {
        return makeResult()
    }

    func fetchEvents<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
        from startDate: Date,
        to endDate: Date
    ) -> Result<[any ModelConvertible], Error> {
        return makeResult()
    }

    func fetchTeams<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int
    ) -> Result<[any ModelConvertible], Error> {
        return makeResult()
    }

    func fetchTeam<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        teamId: Int
    ) -> Result<[any ModelConvertible], Error> {
        return makeResult()
    }

    private func makeResult() -> Result<[any ModelConvertible], Error> {
        if isConnected {
            return .success([])
        } else {
            return .failure(FakeNetworkError.notConnected)
        }
    }
}
