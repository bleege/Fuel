//
//  StopDetailViewController.swift
//  Fuel
//
//  Created by Brad Leege on 1/15/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//


import UIKit

class StopDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTapToDismissRecognizer()
    }
    
    private func setupTapToDismissRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}
