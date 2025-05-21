//
//  LeaguesTableViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    
    @IBOutlet weak var aiLeagues: UIActivityIndicatorView!
    
    var presenter: LeaguesPresenter!
    var router: LeaguesRouter!
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = presenter.title
        tableView.rowHeight = 70
        aiLeagues.startAnimating()
        
        presenter.loadLeagues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch presenter.mode {
            case .favorites: presenter.loadLeagues()
            case .sport: presenter.updateFavoriteState(leagues: leagues)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = leagues[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell") as! LeagueTableViewCell
        cell.configure(with: league)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.leagueSelected(leagues[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let league = leagues[indexPath.row]
        
        let favoriteAction = UIContextualAction(
            style: league.isFavorite ? .destructive : .normal,
            title: nil,
            handler: { _, _, completionHandler in
                self.presenter.setFavorite(league: league, isFavorite: !league.isFavorite, completionHandler: completionHandler)
            }
        )
        favoriteAction.backgroundColor = UIColor.systemPink
        favoriteAction.image = UIImage(systemName: league.isFavorite ? "heart.slash.fill" : "heart.fill")
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

extension LeaguesTableViewController: LeaguesView {
    func showLeagues(_ leagues: [League], sport: Sport?, cached: Bool?) {
        aiLeagues.stopAnimating()
        
        navigationItem.title = switch cached {
            case true: "\(presenter.title) (Cached)"
            case false: presenter.title
            default: navigationItem.title
        }
        
        self.leagues = leagues
        tableView.reloadData()
    }
    
    func showError(title: String, message: String) {
        aiLeagues.stopAnimating()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
    
    func replaceLeague(_ league: League, with newLeague: League) {
        if let index = leagues.firstIndex(where: { league == $0 }) {
            switch presenter.mode {
                case .favorites:
                    leagues.remove(at: index)
                    tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    
                case .sport:
                    leagues.remove(at: index)
                    leagues.insert(newLeague, at: index)
            }
        }
    }
    
    func navigateToLeagueDetails(_ league: League) {
        router.navigateToEvents(with: navigationController!, league: league)
    }
}
