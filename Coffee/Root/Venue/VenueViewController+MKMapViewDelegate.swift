//
//  VenueViewController+MKMapViewDelegate.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import MapKit

extension VenueViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation.isKind(of: MKUserLocation.self) {
        case true:
            return nil
        case false:
            let v = MKMarkerAnnotationView()
            v.glyphText = "☕️"
            v.markerTintColor = .white
            return v
        }
    }
}
