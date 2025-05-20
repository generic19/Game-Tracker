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
        assembleData(container: container)
        assembleDomain(container: container)
        assemblePresentation(container: container)
        assembleRouting(container: container)
    }
    
    private func assembleData(container: Container) {
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
    
    private func assembleDomain(container: Container) {
        container.register(GetLeaguesUseCase.self) { r in
            GetLeaguesUseCase(repository: r.resolve(LeaguesRepository.self)!)
        }
        
        container.register(GetFavoriteLeaguesUseCase.self) { r in
            GetFavoriteLeaguesUseCase(repository: r.resolve(LeaguesRepository.self)!)
        }
        
        container.register(SetFavoriteLeagueUseCase.self) { r in
            SetFavoriteLeagueUseCase(repository: r.resolve(LeaguesRepository.self)!)
        }
        
        container.register(UpdateLeaguesFavoriteStateUseCase.self) { r in
            UpdateLeaguesFavoriteStateUseCase(repository: r.resolve(LeaguesRepository.self)!)
        }
    }
    
    private func assemblePresentation(container: Container) {
        container.register(LeaguesPresenter.self) { (r, args: LeaguesPresenterArguments) in
            LeaguesPresenter(
                getLeaguesUseCase: r.resolve(GetLeaguesUseCase.self)!,
                getFavoriteLeaguesUseCase: r.resolve(GetFavoriteLeaguesUseCase.self)!,
                setFavoriteLeaguesUseCase: r.resolve(SetFavoriteLeagueUseCase.self)!,
                updateLeaguesFavoriteStateUseCase: r.resolve(UpdateLeaguesFavoriteStateUseCase.self)!,
                arguments: args
            )
        }
    }
    
    private func assembleRouting(container: Container) {
        container.register(LeaguesRouter.self, factory: { r in
            ConcreteLeaguesRouter(resolver: r)
        })
    }
}
