//
//  NetworkMonitor.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Network
import Foundation

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .wiredEthernet
    ]
}

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    private(set) var isExpensive = false
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
      monitor.pathUpdateHandler = { [weak self] path in
      self?.isConnected = path.status != .unsatisfied
      self?.isExpensive = path.isExpensive
      // Identifies the current connection type from the
      // list of potential network link types
      self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
      }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
    
}

