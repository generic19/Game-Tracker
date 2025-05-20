//
//  CoreDataLeaguesDAO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

import CoreData

class CoreDataLeaguesDAO: LeaguesDAO {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func getFavorites(onlyForSport sport: Sport?) -> Result<[LeagueEntity], Error> {
        let request = LeagueEntity.fetchRequest()
        
        if let sportRaw = sport?.rawValue {
            request.predicate = NSPredicate(format: "sportRaw = %@", sportRaw)
        }
        
        do {
            let leagues = try viewContext.fetch(request)
            return .success(leagues)
        } catch let error {
            return .failure(error)
        }
    }
    
    func setFavorite(league: League) -> Result<LeagueEntity, Error> {
        let entity = LeagueEntity(context: viewContext)
        
        entity.sportRaw = league.sport.rawValue
        entity.id = Int64(league.id)
        entity.name = league.name
        entity.categoryName = league.categoryName
        entity.logo = league.logo
        entity.categoryLogo = league.categoryLogo
        
        do {
            try viewContext.save()
            return .success(entity)
        } catch {
            viewContext.rollback()
            return .failure(error)
        }
    }
    
    func unsetFavorite(leagueById leagueId: Int64) -> Result<Void, Error> {
        let request = LeagueEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", leagueId)
        request.fetchLimit = 1
        
        do {
            if let league = try viewContext.fetch(request).first {
                viewContext.delete(league)
                try viewContext.save()
            }
            
            return .success(())
        }
        catch let error {
            return .failure(error)
        }
    }
}
