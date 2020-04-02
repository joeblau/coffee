//
//  DetailsViewController.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import MapKit

class VenueViewController: UIViewController {

    private let groupEvent: GroupEvent
    
    lazy var mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = false
        v.showsUserLocation = true
        v.delegate = self
        return v
    }()

    lazy var venueLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        l.textColor = .label
        l.numberOfLines = 0
        return l
    }()
    
    lazy var automobileButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 4
        b.setTitleColor(.label, for: .normal)
        b.backgroundColor = .systemGroupedBackground
        return b
    }()
    
    lazy var transitButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 4
        b.setTitleColor(.label, for: .normal)
        b.backgroundColor = .systemGroupedBackground
        return b
    }()
    
    lazy var walkingButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 4
        b.setTitleColor(.label, for: .normal)
        b.backgroundColor = .systemGroupedBackground
        return b
    }()
    
    lazy var groupNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        l.textColor = .secondaryLabel
        l.numberOfLines = 0
        return l
    }()
    
    lazy var eventRangeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title3)
        l.textColor = .secondaryLabel
        return l
    }()
    
    lazy var etaStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [automobileButton, transitButton, walkingButton])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.distribution = .fillEqually
        v.spacing = UIStackView.spacingUseSystem
        return v
    }()
    
    lazy var contentView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [venueLabel, groupNameLabel, eventRangeLabel, etaStackView, UIView()])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = UIStackView.spacingUseSystem
        return v
    }()
    
    let transportationTypes: [MKDirectionsTransportType] = [.automobile,
                                                           .transit,
                                                           .walking]
    
    init(groupEvent: GroupEvent) {
        self.groupEvent = groupEvent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        Current.locationManager.requestWhenInUseAuthorization()
        Current.locationManager.startMonitoringSignificantLocationChanges()
        
        venueLabel.text = groupEvent.venue.name
        groupNameLabel.text = groupEvent.name
        
        do {
            let startTime = DateFormatter.hoursMinutes.string(from: groupEvent.startAt)
            let endTime = DateFormatter.hoursMinutes.string(from: groupEvent.endAt)
            eventRangeLabel.text = "\(startTime) — \(endTime)"
        }
        
        let annotaiton = MKPointAnnotation()
        annotaiton.coordinate = CLLocationCoordinate2D(latitude: groupEvent.venue.location.latitude,
                                                       longitude: groupEvent.venue.location.longitude)
        mapView.addAnnotation(annotaiton)
        
        view.addSubview(mapView)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        guard let sourceCoordiante = mapView.annotations.first?.coordinate,
            let destinationCoordiante = mapView.annotations.last?.coordinate,
            mapView.annotations.count == 2 else { return }

        transportationTypes.forEach { type in
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordiante)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordiante)

            let request = MKDirections.Request()
            request.transportType = type
            request.source = MKMapItem(placemark: sourcePlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            
            let directions = MKDirections(request: request)
            directions.calculateETA { (eta, error) in
                guard let eta = eta else { return }
                self.update(eta: eta)
            }
        }
    }
    
    private func update(eta: MKDirections.ETAResponse) {
        let currentDate = Date()
        let timeUntilArrival = DateFormatter.relativeShort.localizedString(for: eta.expectedArrivalDate,
                                                    relativeTo: currentDate)
        DispatchQueue.main.async {
            switch eta.transportType {
            case .automobile:
                self.automobileButton.setTitle("🚘 \(timeUntilArrival)", for: .normal)
            case .transit:
                self.transitButton.setTitle("🚊 \(timeUntilArrival)", for: .normal)
            case .walking:
                self.walkingButton.setTitle("🚶‍♀️ \(timeUntilArrival)", for: .normal)
            default: break
            }
        }
    }
}
