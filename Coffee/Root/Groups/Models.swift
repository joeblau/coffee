//
//  Models.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import Foundation

enum GroupSection: Int, CaseIterable {
    case groups
}

struct GroupValue: Hashable {
    let group: CoffeeGroup
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: GroupValue, rhs: GroupValue) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
