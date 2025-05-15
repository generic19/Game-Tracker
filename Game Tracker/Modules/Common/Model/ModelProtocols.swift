//
//  ModelTypes.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//

protocol Model {}

protocol ModelConvertible {
    associatedtype ModelType: Model
    func toModel() -> ModelType
}

protocol ModelInitializable {
    associatedtype ModelType: Model
    init(fromModel: ModelType)
}
