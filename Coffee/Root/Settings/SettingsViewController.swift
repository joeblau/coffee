//
//  SettingsViewController.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    let settings = [
        SettingSection(header: nil, footer: nil, values: [
            SettingValue(title: "Notifications", description: nil, icon: UIImage(systemName: "app.badge")),
            SettingValue(title: "Share", description: "Share", icon: UIImage(systemName: "square.and.arrow.up"))
        ]),
        SettingSection(header: "Community", footer: nil, values: [
            SettingValue(title: "Website", description: "https://coffeecoffeecofeee.coffee", icon: UIImage(systemName: "safari")),
            SettingValue(title: "Source Code", description: "https://github.com/joeblau/coffee", icon: UIImage(systemName: "chevron.left.slash.chevron.right"))
        ])
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: NSLocalizedString("tab_settings_title", comment: "Settings tab bar title"),
                                  image: UIImage(systemName: "square.split.1x2"),
                                  selectedImage: UIImage(systemName: "square.split.1x2.fill"))
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var settingsTableView: SettingsTableView = {
        let v = SettingsTableView()
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("tab_settings_title", comment: "Settings tab")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(settingsTableView)
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
