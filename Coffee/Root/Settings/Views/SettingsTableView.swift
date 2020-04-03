//
//  SettingsTableView.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class SettingsTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        translatesAutoresizingMaskIntoConstraints = false
        register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
