//
//  EventsPresenter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

protocol EventsView: AnyObject {
    func updateLeague()
    func showUpcomingEvents(_ events: [Event])
    func showRecentEvents(_ events: [Event])
    func showTeams(_ teams: [Team])
    func showError(title: String, message: String)
    func navigateToTeam(_ team: Team)
}

class EventsPresenter {
    private let fetchUpcomingEventsUseCase: FetchUpcomingEventsUseCase
    private let fetchRecentEventsUseCase: FetchRecentEventsUseCase
    private let fetchLeagueTeamsUseCase: FetchLeagueTeamsUseCase
    private let setFavoriteLeagueUseCase: SetFavoriteLeagueUseCase
    
    weak var view: (any EventsView)?
    var league: League!
    
    init(fetchUpcomingEventsUseCase: FetchUpcomingEventsUseCase, fetchRecentEventsUseCase: FetchRecentEventsUseCase, fetchLeagueTeamsUseCase: FetchLeagueTeamsUseCase, setFavoriteLeagueUseCase: SetFavoriteLeagueUseCase) {
        self.fetchUpcomingEventsUseCase = fetchUpcomingEventsUseCase
        self.fetchRecentEventsUseCase = fetchRecentEventsUseCase
        self.fetchLeagueTeamsUseCase = fetchLeagueTeamsUseCase
        self.setFavoriteLeagueUseCase = setFavoriteLeagueUseCase
    }
    
    func loadData() {
        let league = self.league!
        
        DispatchQueue.global(qos: .default).async {
            let group = DispatchGroup()
            
            var upcomingResult: Result<[Event], Error>!
            var recentResult: Result<[Event], Error>!
            var teamsResult: Result<[Team], Error>!
            
            group.enter()
            self.fetchUpcomingEventsUseCase.execute(league: league) { result in
                upcomingResult = result
                group.leave()
            }
            
            group.enter()
            self.fetchRecentEventsUseCase.execute(league: league) { result in
                recentResult = result
                group.leave()
            }
            
            if league.sport != .tennis {
                group.enter()
                
                self.fetchLeagueTeamsUseCase.execute(league: league) { result in
                    teamsResult = result
                    group.leave()
                }
            }
            
            group.wait()
            
            DispatchQueue.main.async {
                var errors = [(String, String)]()
                
                switch upcomingResult! {
                    case .success(let events): self.view?.showUpcomingEvents(events)
                    case .failure(let error): errors.append(("upcoming events", error.localizedDescription))
                }
                
                switch recentResult! {
                    case .success(let events): self.view?.showRecentEvents(events)
                    case .failure(let error): errors.append(("recent events", error.localizedDescription))
                }
                
                if league.sport != .tennis {
                    switch teamsResult! {
                        case .success(let teams): self.view?.showTeams(teams)
                        case .failure(let error): errors.append(("teams", error.localizedDescription))
                    }
                }
                
                if !errors.isEmpty {
                    let joinedErrors = errors.compactMap({ $0.0 }).joined(separator: ", ")
                    
                    let title = "Could not fetch: \(joinedErrors)"
                    let message = errors
                        .compactMap({ "\($0.0.capitalized): \($0.1)" })
                        .joined(separator: "\n\n")
                    
                    self.view?.showError(title: title, message: message)
                }
            }
        }
    }
    
    func toggleFavorite() {
        setFavoriteLeagueUseCase.execute(league: league, isFavorite: !league.isFavorite) { result in
            switch result {
                case .success(let league):
                    DispatchQueue.main.async {
                        self.league = league
                        self.view?.updateLeague()
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.view?.showError(title: "Could not set league favorite state", message: error.localizedDescription)
                    }
            }
        }
    }
    
    func didSelectTeam(_ team: Team) {
        view?.navigateToTeam(team)
    }
}
