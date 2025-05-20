//
//  EventsViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    
    var presenter: EventsPresenter!
    var router: EventsRouter!
    
    private var upcomingEvents: [Event]?
    private var recentEvents: [Event]?
    private var teams: [Team]?
    
    private enum Section {
        case header
        case upcomingEvents
        case recentEvents
        case teams
    }
    
    private var sections: [Section] {
        var result: [Section] = [.header]
        
        if upcomingEvents?.count ?? 0 > 0 { result.append(.upcomingEvents) }
        if recentEvents?.count ?? 0 > 0 { result.append(.recentEvents) }
        if teams?.count ?? 0 > 0 { result.append(.teams) }
        
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = presenter.league.name
        btnFavorite.image = UIImage(systemName: presenter.league.isFavorite ? "heart.fill" : "heart")
        
        setupCollectionView()
        presenter.loadData()
    }
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        presenter.toggleFavorite()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            UINib(nibName: "LeagueHeaderCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "LeagueHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "EventCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "EventCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "TeamCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TeamCollectionViewCell"
        )
        
        collectionView.register(
            UINib(nibName: "SectionTitleCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionTitleCollectionViewCell"
        )
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch self.sections[sectionIndex] {
                case .header:
                    let size = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(220)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: size)
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: size,
                        subitems: [item]
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 0, leading: 0, bottom: 16, trailing: 0
                    )
                    return section
                    
                case .upcomingEvents:
                    let size = NSCollectionLayoutSize(
                        widthDimension: .absolute(300),
                        heightDimension: .absolute(200)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: size)
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: size, subitems: [item]
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .groupPagingCentered
                    section.interGroupSpacing = 12
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 16, leading: 16, bottom: 16, trailing: 16
                    )
                    let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(50)
                    )
                    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                    section.boundarySupplementaryItems = [sectionHeader]
                    return section
                    
                case .recentEvents:
                    let size = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(220)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: size)
                    let group = NSCollectionLayoutGroup.vertical(
                        layoutSize: size, subitems: [item]
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    section.interGroupSpacing = 12
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 16, leading: 16, bottom: 16, trailing: 16
                    )
                    let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(50)
                    )
                    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                    section.boundarySupplementaryItems = [sectionHeader]
                    return section
                    
                case .teams:
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .absolute(130),
                        heightDimension: .absolute(160)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(160)
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize, subitems: [item]
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    section.interGroupSpacing = 12
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 16, leading: 16, bottom: 32, trailing: 16
                    )
                    let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(50)
                    )
                    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                    section.boundarySupplementaryItems = [sectionHeader]
                    return section
            }
        }
    }
}

extension EventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return switch sections[section] {
            case .header: 1
            case .upcomingEvents: upcomingEvents?.count ?? 0
            case .recentEvents: recentEvents?.count ?? 0
            case .teams: teams?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueHeaderCollectionViewCell", for: indexPath) as! LeagueHeaderCollectionViewCell
                cell.configure(with: presenter.league)
                return cell
                
            case .upcomingEvents:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
                cell.configure(with: upcomingEvents![indexPath.item])
                return cell
                
            case .recentEvents:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
                cell.configure(with: recentEvents![indexPath.row])
                return cell
                
            case .teams:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
                cell.configure(with: teams![indexPath.row])
                return cell
        }
    }
}

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sections[indexPath.section] == .teams {
            presenter.didSelectTeam(teams![indexPath.row])
        } else {
            collectionView.deselectItem(at: indexPath, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        
        guard kind == UICollectionView.elementKindSectionHeader, section != .header else {
            return UICollectionReusableView()
        }
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionTitleCollectionViewCell", for: indexPath) as! SectionTitleCollectionViewCell
        
        cell.lblTitle.text = switch section {
            case .upcomingEvents: "Upcoming Events"
            case .recentEvents: "Recent Events"
            case .teams: "Teams"
            default: nil
        }
        
        return cell
    }
}

extension EventsViewController: EventsView {
    func updateLeague() {
        btnFavorite.image = UIImage(systemName: presenter.league.isFavorite ? "heart.fill" : "heart")
        collectionView.reloadSections(IndexSet.init(integer: 0))
    }
    
    func showUpcomingEvents(_ events: [Event]) {
        upcomingEvents = events
        collectionView.reloadData()
    }
    
    func showRecentEvents(_ events: [Event]) {
        recentEvents = events
        collectionView.reloadData()
    }
    
    func showTeams(_ teams: [Team]) {
        self.teams = teams
        collectionView.reloadData()
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
    
    func navigateToTeam(_ team: Team) {
        router.navigateToTeam(with: navigationController!, team: team)
    }
}

