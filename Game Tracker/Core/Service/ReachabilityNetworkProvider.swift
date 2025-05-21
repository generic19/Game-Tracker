//
//  ReachabilityNetworkProvider.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import Reachability

class ReachabilityNetworkStatusProvider: NetworkStatusProvider {
    private let reachablility = try! Reachability()

    var isConnected: Bool {
        reachablility.connection != .unavailable
    }
    
    init() {
        try! reachablility.startNotifier()
    }
    
    deinit {
        reachablility.stopNotifier()
    }
}
