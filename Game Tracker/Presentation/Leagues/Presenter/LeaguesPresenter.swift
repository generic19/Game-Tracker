//
//  LeaguesPresenter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Foundation

protocol LeaguesView: AnyObject {
    func showLeagues(_ leagues: [League], sport: Sport?, cached: Bool?)
    func showError(title: String, message: String)
    func replaceLeague(_ league: League, with newLeague: League)
    func navigateToLeagueDetails(_ league: League)
}

enum LeaguesMode {
    case sport(Sport)
    case favorites
}

struct LeaguesPresenterArguments {
    let mode: LeaguesMode
}

class LeaguesPresenter {
    weak var view: (any LeaguesView)?
    
    let getLeaguesUseCase: GetLeaguesUseCase
    let getFavoriteLeaguesUseCase: GetFavoriteLeaguesUseCase
    let setFavoriteLeaguesUseCase: SetFavoriteLeagueUseCase
    let updateLeaguesFavoriteStateUseCase: UpdateLeaguesFavoriteStateUseCase
    let networkStatusProvider: NetworkStatusProvider
    
    var mode: LeaguesMode
        
    private var cachedErrorShown = false
    
    var title: String {
        let name = switch mode {
            case .sport(let sport): sport.localizedName
            case .favorites: NSLocalizedString("favorite", comment: "For title")
        }
        return String(
            format: NSLocalizedString("format_title", comment: "For title"),
            name
        )
    }
    
    init(
        getLeaguesUseCase: GetLeaguesUseCase,
        getFavoriteLeaguesUseCase: GetFavoriteLeaguesUseCase,
        setFavoriteLeaguesUseCase: SetFavoriteLeagueUseCase,
        updateLeaguesFavoriteStateUseCase: UpdateLeaguesFavoriteStateUseCase,
        networkStatusProvider: NetworkStatusProvider,
        arguments: LeaguesPresenterArguments,
    ) {
        self.getLeaguesUseCase = getLeaguesUseCase
        self.getFavoriteLeaguesUseCase = getFavoriteLeaguesUseCase
        self.setFavoriteLeaguesUseCase = setFavoriteLeaguesUseCase
        self.updateLeaguesFavoriteStateUseCase = updateLeaguesFavoriteStateUseCase
        self.networkStatusProvider = networkStatusProvider
        self.mode = arguments.mode
    }
    
    func loadLeagues() {
        switch mode {
            case .sport(let sport):
                getLeaguesUseCase.execute(sport: sport) { [weak self] result in
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        
                        switch result {
                            case .success(let leagues):
                                self.view?.showLeagues(leagues, sport: sport, cached: false)
                                
                            case .cached(let leagues, let error):
                                self.view?.showLeagues(leagues, sport: sport, cached: true)
                                
                            case .failure(let error):
                                self.view?.showError(
                                    title: String(
                                        format: NSLocalizedString("format_league_error_sport", comment: "League error"),
                                        sport.localizedName
                                    ),
                                    message: error.localizedDescription
                                )
                        }
                    }
                }
                
            case .favorites:
                getFavoriteLeaguesUseCase.execute { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                            case .success(let leagues):
                                self?.view?.showLeagues(leagues, sport: nil, cached: false)
                                
                            case .failure(let error):
                                self?.view?.showError(
                                    title: NSLocalizedString("league_error_favorite", comment: "League error"),
                                    message: error.localizedDescription
                                )
                        }
                    }
                }
        }
    }
    
    func updateFavoriteState(leagues: [League]) {
        updateLeaguesFavoriteStateUseCase.execute(leagues: leagues) { leagues in
            let sport: Sport? = switch self.mode {
                case .favorites: nil
                case .sport(let sport): sport
            }
            
            DispatchQueue.main.async {
                self.view?.showLeagues(leagues, sport: sport, cached: nil)
            }
        }
    }
    
    func setFavorite(league: League, isFavorite: Bool, completionHandler: ((Bool) -> Void)? = nil) {
        setFavoriteLeaguesUseCase.execute(league: league, isFavorite: isFavorite) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let newLeague):
                        completionHandler?(true)
                        self?.view?.replaceLeague(league, with: newLeague)
                        
                    case .failure(let error):
                        completionHandler?(false)
                        self?.view?.showError(
                            title: NSLocalizedString("league_error_set_favorite", comment: "League error"),
                            message: error.localizedDescription
                        )
                }
            }
        }
    }
    
    func leagueSelected(_ league: League) {
        if networkStatusProvider.isConnected {
            view?.navigateToLeagueDetails(league)
        } else {
            view?.showError(
                title: NSLocalizedString("error_connectivity_title", comment: "League error"),
                message: NSLocalizedString("error_connectivity_message", comment: "League error")
            )
        }
    }
}
