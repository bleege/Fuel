//
//  OverviewPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 12/20/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OverviewPresenter: OverviewContractPresenter {
    
    private var view: OverviewContractView?
    
    private let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    private let disposeBag = DisposeBag()
    
    init() {
        // No Op
    }
    
    // MARK: OverviewContractPresenter
    
    func onAttach(view: OverviewContractView) {
        self.view = view
        loadFuelStops()
    }
    
    func onDetach() {
        self.view = nil
    }
    
    func loadFuelStops() {
//        let fuelStops = dataManager.getAllFuelStops()
//        print("number of fuelStops found = \(fuelStops.count)")
//        view?.displayStops(fuelStops: fuelStops)
        
        dataManager.getAllFuelStops().toArray()
            .subscribe(onNext: { (element) in
                print("Element = \(element)")
            }, onError: { (error) in
                print("Error = \(error)")
            }).disposed(by: disposeBag)
    }
    
    func handleStopSelection(index: Int) {
        self.view?.displayStopOnMap(index: index)
        self.view?.displayStopDataView(index: index)
    }
 
    func handleAddStopFABTap() {
        view?.displayAddStopViewController()
    }

}
