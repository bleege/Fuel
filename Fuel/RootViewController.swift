//
//  RootViewController.swift
//  Fuel
//
//  Created by Brad Leege on 8/11/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    private let navDrawer = NavDrawerViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        isNavigationBarHidden = true
        
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    


}
