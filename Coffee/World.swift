//
//  World.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import Foundation
import CoreLocation

struct World {
    let coffeeAPI = CoffeeAPIController()
    let locationManager = CLLocationManager()
}

let Current = World()
