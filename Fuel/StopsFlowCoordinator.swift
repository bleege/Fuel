//
//  StopsFlowCoordinator.swift
//  Fuel
//
//  Created by Brad Leege on 7/13/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import Foundation
import UIKit

class StopsFlowCoordinator: Coordinator {

    weak var rootViewController: RootViewController?
    
    init(_ rootViewController: RootViewController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        self.rootViewController?.viewControllers = [OverviewViewController()]
    }
    
}
