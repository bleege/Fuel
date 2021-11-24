//
//  NavDrawerTableHeader.swift
//  Fuel
//
//  Created by Brad Leege on 11/17/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import UIKit

class NavDrawerTableHeader: UIView {

    private let headerView: UILabel = {
        let label = UILabel()
        label.text = "Fuel"
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierachy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewHierachy()
    }
    
    private func setupViewHierachy() {
        frame = CGRect(x: 0, y: 0, width: 0, height: 50)

        addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
}
