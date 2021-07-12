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

    let navigationController: UINavigationController = {
        let nav = UINavigationController(rootViewController: OverviewViewController())
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    func start() {

    }
    
}
