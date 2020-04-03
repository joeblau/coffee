// World.swift
// Copyright (c) 2020 Joe Blau

import CoreLocation
import Foundation

struct World {
    let coffeeAPI = CoffeeAPIController()
    let locationManager = CLLocationManager()
}

let Current = World()
