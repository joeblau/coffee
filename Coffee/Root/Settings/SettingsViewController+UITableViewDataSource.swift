//
//  SettingsViewController+UITableViewDataSource.swift
//  Coffee
//
//  Created by Joe Blau on 4/3/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id,
                                                 for: indexPath) as? SettingTableViewCell else {
            preconditionFailure("Could not deque SettingTableViewCell")
        }
        
        let settingValue = settings[indexPath.section].values[indexPath.row]
        cell.configure(setting: settingValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settings[section].header
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settings[section].footer
    }
}
