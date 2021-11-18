//
//  NavDrawerTableFooter.swift
//  Fuel
//
//  Created by Brad Leege on 11/17/21.
//  Copyright © 2021 Brad Leege. All rights reserved.
//

import UIKit

class NavDrawerTableFooter: UIView {

    private let footerView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        frame = CGRect(x: 0, y: 0, width: 0, height: 100)

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            footerView.text = "Version: \(appVersion) (\(buildNumber))"
        }
        
        addSubview(footerView)
        
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 8),
            footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
}
