//
//  AlamofireAPIServiceTests.swift
//  Game TrackerTests
//
//  Created by Basel Alasadi on 09/05/2025.
//

import XCTest
@testable import Game_Tracker

final class AlamofireAPIServiceTests: XCTestCase {
    var service: AlamofireSportsAPIService!
    
    override func setUp() {
        super.setUp()
        service = AlamofireSportsAPIService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testFetchLeaguesReturnsDTO() {
        let ex = expectation(description: "Leagues fetched")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.service.fetchLeagues(
                as: FootballLeagueRemoteDTO.self,
                sport: .football
            )
            
            switch result {
                case .success(let models):
                    XCTAssertNotNil(models)
                    XCTAssertTrue(models is [FootballLeagueRemoteDTO])
                    
                case .failure(let error):
                    XCTFail("fetchLeagues failed: \(error)")
            }
            
            ex.fulfill()
        }
        
        wait(for: [ex], timeout: 10)
    }
    
    func testFetchEventsReturnsDTO() {
        let ex = expectation(description: "Leagues fetched")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let startDate = Date(timeIntervalSinceNow: 7 * 24 * 60 * 60)
            let endDate = Date(timeIntervalSinceNow: 0)
            
            let result = self.service.fetchEvents(
                as: FootballEventRemoteDTO.self,
                sport: .football,
                leagueId: 152,
                from: startDate,
                to: endDate
            )
            
            switch result {
                case .success(let models):
                    XCTAssertNotNil(models)
                    XCTAssertTrue(models is [FootballEventRemoteDTO])
                    
                case .failure(let error):
                    XCTFail("fetchEvents failed: \(error)")
            }
            
            ex.fulfill()
        }
        
        wait(for: [ex], timeout: 10)
    }
    
    func testFetchTeamsReturnsDTO() {
        let ex = expectation(description: "Leagues fetched")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.service.fetchTeams(
                as: FootballTeamRemoteDTO.self,
                sport: .football,
                leagueId: 152
            )
            
            switch result {
                case .success(let models):
                    XCTAssertNotNil(models)
                    XCTAssertTrue(models is [FootballTeamRemoteDTO])
                    
                case .failure(let error):
                    XCTFail("fetchTeams failed: \(error)")
            }
            
            ex.fulfill()
        }
        
        wait(for: [ex], timeout: 10)
    }
}
