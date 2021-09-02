//
//  RootViewController.swift
//  Fuel
//
//  Created by Brad Leege on 8/11/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private let navDrawer = NavDrawerViewController()
    
    private lazy var backgroundMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideNavDrawer)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let navController: UINavigationController = {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        navController.view.backgroundColor = .yellow
        navController.view.translatesAutoresizingMaskIntoConstraints = false
        return navController
    }()
    
    private var leadingNavDrawerAnchor: NSLayoutConstraint?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.

        addChild(navController)
        navController.didMove(toParent: self)
        view.addSubview(navController.view)

        view.addSubview(backgroundMaskView)

        addChild(navDrawer)
        navDrawer.didMove(toParent: self)
        view.addSubview(navDrawer.view)
        
        leadingNavDrawerAnchor = navDrawer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            navDrawer.view.topAnchor.constraint(equalTo: view.topAnchor),
            navDrawer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            navDrawer.view.widthAnchor.constraint(equalToConstant: 200.0),
            leadingNavDrawerAnchor!,
            navController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundMaskView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundMaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundMaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundMaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        leadingNavDrawerAnchor?.constant = 0
    }
    
    func startNewFlow(with viewController: UIViewController) {
        navController.viewControllers.removeAll()
        navController.viewControllers.append(viewController)
    }

    @objc
    func hideNavDrawer() {
        UIView.animate(withDuration: 1.0, animations: {
            self.leadingNavDrawerAnchor?.constant = -200.0
            self.view.layoutIfNeeded()
        })
    }

}
