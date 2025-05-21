//
//  TeamViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import UIKit
import SDWebImage

class TeamViewController: UIViewController {
    private enum Section {
        case header
        case coaches
        case players
    }
    
    var team: Team!
    private var sections: [Section]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = team.name
        
        sections = [.header]
        if team?.coaches?.count ?? 0 > 0 {
            sections.append(.coaches)
        }
        if team?.players?.count ?? 0 > 0 {
            sections.append(.players)
        }
    }
}

extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        let section = sections[sectionIndex]
        
        return switch section {
            case .header: 1
            case .coaches: team.coaches?.count ?? 0
            case .players: team.players?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
            case .header:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TeamHeaderTableViewCell", for: indexPath) as! TeamHeaderTableViewCell
                cell.configure(with: team)
                return cell
                
            case .coaches:
                guard let person = team.coaches?[indexPath.row] else { return UITableViewCell() }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
                cell.configure(with: person)
                return cell
                
            case .players:
                guard let person = team.players?[indexPath.row] else { return UITableViewCell() }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
                cell.configure(with: person)
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        return switch section {
            case .header: 200
            case .coaches: 70
            case .players: 70
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        let section = sections[sectionIndex]
        return switch section {
            case .header: nil
            case .coaches: NSLocalizedString("section_coaches", comment: "Team section name")
            case .players: NSLocalizedString("section_players", comment: "Team section name")
        }
    }
}
