//
//  NetworkStatusProvider.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import Reachability

protocol NetworkStatusProvider {
    var isConnected: Bool { get }
}
