//
//  StopDetailViewController.swift
//  Fuel
//
//  Created by Brad Leege on 1/15/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//


import UIKit

class StopDetailViewController: UIViewController {
    
    // MARK: - Data Presentation Views
    private let stopDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ppgLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gallonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tripOdometerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tripMPGLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let odometerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let octaneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    var stopData: FuelStop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupViewHierarchy()
        
        stopDateLabel.text = stopData?.stopDate.longFormat()
        ppgLabel.text = stopData?.pricePerGallon.currencyFormat()
        gallonsLabel.text = stopData?.gallons.gallonFormat()
        costLabel.text = stopData?.price.currencyFormat()
        tripOdometerLabel.text = stopData?.tripOdometer.tripOdometerFormat()
        tripMPGLabel.text = stopData?.mpg.mpgFormat()
        if let odometer = stopData?.odometer {
            odometerLabel.text = String(odometer)
        }
        if let octane = stopData?.octane {
            octaneLabel.text = String(octane)
        }
        
        setupTapToDismissRecognizer()
    }
    
    // MARK: - View Hierarchy Setup
    private func setupViewHierarchy() {
        view.backgroundColor = UIColor(red: 242.0 / 255.0, green: 243.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        
        view.addSubview(stopDateLabel)
        
        let topStack = UIStackView()
        topStack.axis = .horizontal
        topStack.alignment = .fill
        topStack.distribution = .fillProportionally
        topStack.spacing = 0
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(createPairingStack(dataLabel: costLabel, descriptionText: "Price"))
        topStack.addArrangedSubview(createPairingStack(dataLabel: gallonsLabel, descriptionText: "Gallons"))
        topStack.addArrangedSubview(createPairingStack(dataLabel: ppgLabel, descriptionText: "$ / Gallon"))

        view.addSubview(topStack)
        
        let bottomLeftStack = UIStackView()
        bottomLeftStack.axis = .vertical
        bottomLeftStack.alignment = .fill
        bottomLeftStack.distribution = .equalCentering
        bottomLeftStack.spacing = 28
        bottomLeftStack.addArrangedSubview(createPairingStack(dataLabel: tripOdometerLabel, descriptionText: "Trip Odometer"))
        bottomLeftStack.addArrangedSubview(createPairingStack(dataLabel: odometerLabel, descriptionText: "Odometer"))

        let bottomRightStack = UIStackView()
        bottomRightStack.axis = .vertical
        bottomRightStack.alignment = .fill
        bottomRightStack.distribution = .equalCentering
        bottomRightStack.spacing = 28
        bottomRightStack.addArrangedSubview(createPairingStack(dataLabel: tripMPGLabel, descriptionText: "Trip MPG"))
        bottomRightStack.addArrangedSubview(createPairingStack(dataLabel: octaneLabel, descriptionText: "Octane"))

        let bottomStack = UIStackView()
        bottomStack.axis = .horizontal
        bottomStack.alignment = .fill
        bottomStack.distribution = .fillEqually
        bottomStack.spacing = 0
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.addArrangedSubview(bottomLeftStack)
        bottomStack.addArrangedSubview(bottomRightStack)
        
        view.addSubview(bottomStack)

        // TODO - Layout Constraints
        NSLayoutConstraint.activate([
            stopDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            stopDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stopDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            topStack.topAnchor.constraint(equalTo: stopDateLabel.bottomAnchor, constant: 20),
            topStack.leadingAnchor.constraint(equalTo: stopDateLabel.leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: stopDateLabel.trailingAnchor),
            bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 28.0),
            bottomStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: topStack.trailingAnchor),
//            bottomStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])        
    }
    
    private func createPairingStack(dataLabel: UILabel, descriptionText: String) -> UIStackView {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0.0
        stack.addArrangedSubview(dataLabel)
        stack.addArrangedSubview(createDescriptionLabel(text: descriptionText))
        
        return stack
    }

    private func createDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    // MARK: - Dismiss Screen Gesture Handling
    
    private func setupTapToDismissRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}
