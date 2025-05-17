//
//  ServicesAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Swinject
import CoreData

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NSManagedObjectContext.self, factory: {_ in
            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        })
        
        container.register(SportsAPIService.self) { _ in AlamofireSportsAPIService() }
    }
}
