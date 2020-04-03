//
//  DataSourceModels.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

// MARK: - Group

enum GroupSection: Int, CaseIterable {
    case groups
}

struct GroupValue: Hashable {
    let group: CoffeeGroup
}

// MARK: - Event

enum EventSection: Int, CaseIterable {
    case events
}

struct EventValue: Hashable {
    let event: GroupEvent
}

// MARK: - Settings

struct SettingSection {
    let header: String?
    let footer: String?
    let values: [SettingValue]
}

struct SettingValue: Hashable {
    let title: String
    let description: String?
    let icon: UIImage?
}
