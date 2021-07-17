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

    weak var navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController?.viewControllers = [OverviewViewController()]
    }
    
}
