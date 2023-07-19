//
//  NetworkConnectStatusManager.swift
//  Kashihon
//
//  Created by t&a on 2023/07/19.
//

import Reachability
import UIKit

class NetworkConnectStatusManager {
    public func getNetworkConnectStatus() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi:
            return true
        case .cellular:
            return true
        case .unavailable:
            return false
        case .none:
            return false
        }
    }
}
