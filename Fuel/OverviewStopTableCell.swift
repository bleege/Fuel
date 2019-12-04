//
//  OverviewStopTableCell.swift
//  Fuel
//
//  Created by Brad Leege on 12/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit

class OverviewStopTableCell: UITableViewCell {
    
    private let stageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stopDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gallonsFilled: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gallons: UILabel = {
        let label = UILabel()
        label.text = "gallons"
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    private func commonSetup() {
        let gray = UIColor(red: 242.0 / 255.0, green: 243.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        backgroundColor = gray
        let backgroundView = UIView()
        backgroundView.backgroundColor = gray
        selectedBackgroundView = backgroundView
        
        stageView.addSubview(stopDate)
        stageView.addSubview(gallonsFilled)
        stageView.addSubview(gallons)
        stageView.addSubview(totalPrice)
        contentView.addSubview(stageView)
        
        NSLayoutConstraint.activate([
            stageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            stageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            stageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stopDate.topAnchor.constraint(equalTo: stageView.topAnchor, constant: 8.0),
            stopDate.leadingAnchor.constraint(equalTo: stageView.leadingAnchor, constant: 8.0),
            stopDate.trailingAnchor.constraint(greaterThanOrEqualTo: stageView.trailingAnchor),
            gallonsFilled.leadingAnchor.constraint(equalTo: stopDate.leadingAnchor),
            gallonsFilled.topAnchor.constraint(equalTo: stopDate.bottomAnchor, constant: 4.0),
            gallonsFilled.bottomAnchor.constraint(equalTo: stageView.bottomAnchor, constant: -8.0),
            gallons.topAnchor.constraint(equalTo: gallonsFilled.topAnchor),
            gallons.leadingAnchor.constraint(equalTo: gallonsFilled.trailingAnchor, constant: 5.0),
            gallons.trailingAnchor.constraint(lessThanOrEqualTo: stageView.trailingAnchor),
            totalPrice.centerYAnchor.constraint(equalTo: stageView.centerYAnchor),
            totalPrice.trailingAnchor.constraint(equalTo: stageView.trailingAnchor, constant: -8.0),
            totalPrice.leadingAnchor.constraint(greaterThanOrEqualTo: stageView.leadingAnchor)
        ])
        
        // Round Corners and Drop Shadow
        self.stageView.layer.cornerRadius = 10
        self.stageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.stageView.layer.shadowRadius = 0.5
        self.stageView.layer.shadowOpacity = 0.2
    }
    
}
