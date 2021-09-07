//
//  NavDrawerViewController.swift
//  Fuel
//
//  Created by Brad Leege on 8/11/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import UIKit

class NavDrawerViewController: UIViewController {

    private lazy var menuTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.systemPink
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
    }
    
    private func setupViewHierarchy() {
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(menuTable)
        
        NSLayoutConstraint.activate([
            menuTable.topAnchor.constraint(equalTo: view.topAnchor),
            menuTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension NavDrawerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension NavDrawerViewController: UITableViewDelegate {
    
    
}