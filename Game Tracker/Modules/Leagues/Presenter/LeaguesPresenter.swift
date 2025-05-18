//
//  LeaguesPresenter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Foundation

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
    
    var mode: LeaguesMode
        
    var title: String {
        let name = switch mode {
            case .sport(let sport): sport.rawValue.capitalized
            case .favorites: "Favorite"
        }
        return "\(name) Leagues"
    }
    
    init(
        getLeaguesUseCase: GetLeaguesUseCase,
        getFavoriteLeaguesUseCase: GetFavoriteLeaguesUseCase,
        setFavoriteLeaguesUseCase: SetFavoriteLeagueUseCase,
        arguments: LeaguesPresenterArguments,
    ) {
        self.getLeaguesUseCase = getLeaguesUseCase
        self.getFavoriteLeaguesUseCase = getFavoriteLeaguesUseCase
        self.setFavoriteLeaguesUseCase = setFavoriteLeaguesUseCase
        self.mode = arguments.mode
    }
    
    func loadLeagues() {
        switch mode {
            case .sport(let sport):
                getLeaguesUseCase.execute(sport: sport) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                            case .success(let leagues):
                                self?.view?.showLeagues(leagues, sport: sport)
                                
                            case .cached(let leagues, let error):
                                self?.view?.showLeagues(leagues, sport: sport)
                                self?.view?.showError(title: "Showing cached leagues.", message: error.localizedDescription)
                                
                            case .failure(let error):
                                self?.view?.showError(title: "Could not get leagues for \(sport).", message: error.localizedDescription)
                        }
                    }
                }
                
            case .favorites:
                getFavoriteLeaguesUseCase.execute { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                            case .success(let leagues):
                                self?.view?.showLeagues(leagues, sport: nil)
                                
                            case .failure(let error):
                                self?.view?.showError(title: "Could not get your favorite leagues.", message: error.localizedDescription)
                        }
                    }
                }
        }
    }
    
    func setFavorite(league: League, isFavorite: Bool) {
        setFavoriteLeaguesUseCase.execute(league: league, isFavorite: isFavorite) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let newLeague):
                        self?.view?.replaceLeague(league, with: newLeague)
                        
                    case .failure(let error):
                        self?.view?.showError(title: "Could not change league favorite status.", message: error.localizedDescription)
                }
            }
        }
    }
    
    func leagueSelected(_ league: League) {
        view?.navigateToLeagueDetails(league)
    }
}
