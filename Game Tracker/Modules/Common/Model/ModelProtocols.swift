//
//  ModelTypes.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//

protocol ModelConvertible {
    associatedtype Model
    func toModel() -> Model
}

protocol ModelInitializable {
    associatedtype Model
    init(fromModel: Model)
}
