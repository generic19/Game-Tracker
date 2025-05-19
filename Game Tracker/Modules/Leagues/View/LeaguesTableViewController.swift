//
//  LeaguesTableViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    var presenter: LeaguesPresenter!
    var router: LeaguesRouter!
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = presenter.title
        presenter.loadLeagues()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let league = leagues[indexPath.row]
        
        cell.textLabel?.text = league.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.leagueSelected(leagues[indexPath.row])
    }
}

extension LeaguesTableViewController: LeaguesView {
    func showLeagues(_ leagues: [League], sport: Sport?) {
        self.leagues = leagues
        tableView.reloadData()
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
    
    func replaceLeague(_ league: League, with newLeague: League) {
        if let index = leagues.firstIndex(where: { league == $0 }) {
            leagues.remove(at: index)
            leagues.insert(newLeague, at: index)
            
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    func navigateToLeagueDetails(_ league: League) {
        router.navigateToEvents(with: navigationController!, league: league)
    }
}
