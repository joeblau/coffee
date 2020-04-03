// VenueViewController+MKMapViewDelegate.swift
// Copyright (c) 2020 Joe Blau

import MapKit
import UIKit

extension VenueViewController: MKMapViewDelegate {
    func mapView(_: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
