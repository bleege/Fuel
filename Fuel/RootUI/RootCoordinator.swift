//
//  RootCoordinator.swift
//  Fuel
//
//  Created by Brad Leege on 7/3/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import Combine
import UIKit

class RootCoordinator: Coordinator {

    let rootViewController = RootViewController()
    
    private var cancellables = Set<AnyCancellable>()
    
    func start() {
        bindPublishers()
        showStopsFlow()
    }
    
    private func bindPublishers() {
        rootViewController.navDrawer.navDrawerItemSelectedPublisher
            .sink(receiveValue: { [weak self] menuIndex in
                if menuIndex == 0 {
                    self?.showStopsFlow()
                }
            })
            .store(in: &cancellables)
    }
    
    private func showStopsFlow() {
        let stops = StopsFlowCoordinator(rootViewController)
        stops.start()
    }
    
}
