//
//  LeaguesAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Swinject
import CoreData

class LeaguesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LeaguesDAO.self) { r in
            return CoreDataLeaguesDAO(
                viewContext: r.resolve(NSManagedObjectContext.self)!
            )
        }
        
        container.register(LeaguesLocalDataSource.self) { r in
            return ConcreteLeaguesLocalDataSource(
                dao: r.resolve(LeaguesDAO.self)!
            )
        }
        
        container.register(LeaguesRemoteDataSource.self) { r in
            return ConcreteLeaguesRemoteDataSource(
                service: r.resolve(SportsAPIService.self)!
            )
        }
        
        container.register(LeaguesRepository.self) { r in
            return ConcreteLeaguesRepository(
                localDataSource: r.resolve(LeaguesLocalDataSource.self)!,
                remoteDataSource: r.resolve(LeaguesRemoteDataSource.self)!
            )
        }
    }
}
