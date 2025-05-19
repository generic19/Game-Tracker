//
//  EventsAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Swinject

class EventsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventsRemoteDataSource.self, factory: { r in
            ConcreteEventsRemoteDataSource(
                service: r.resolve(SportsAPIService.self)!
            )
        })
        
        container.register(EventsRepository.self) { r in
            ConcreteEventsRepository(
                remoteDataSource: r.resolve(EventsRemoteDataSource.self)!
            )
        }
        
        container.register(FetchUpcomingEventsUseCase.self, factory: { r in
            FetchUpcomingEventsUseCase(
                repository: r.resolve(EventsRepository.self)!
            )
        })
        
        container.register(FetchRecentEventsUseCase.self, factory: { r in
            FetchRecentEventsUseCase(
                repository: r.resolve(EventsRepository.self)!
            )
        })
        
        container.register(EventsPresenter.self, factory: { r in
            EventsPresenter(
                fetchUpcomingEventsUseCase: r.resolve(FetchUpcomingEventsUseCase.self)!,
                fetchRecentEventsUseCase: r.resolve(FetchRecentEventsUseCase.self)!,
                fetchLeagueTeamsUseCase: r.resolve(FetchLeagueTeamsUseCase.self)!,
            )
        })
        
        container.register(EventsRouter.self) { r in
            ConcreteEventsRouter(resolver: r)
        }
    }
}
