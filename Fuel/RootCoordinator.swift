//
//  RootCoordinator.swift
//  Fuel
//
//  Created by Brad Leege on 7/3/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {

    let rootViewController = RootViewController()
    
    func start() {
        showStopsFlow()
    }
    
    private func showStopsFlow() {
        let stops = StopsFlowCoordinator(rootViewController)
        stops.start()
    }
    
}
