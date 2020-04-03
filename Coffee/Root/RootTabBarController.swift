// RootTabBarController.swift
// Copyright (c) 2020 Joe Blau

import UIKit

class RootTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [
            UINavigationController(rootViewController: GroupsViewController()),
            UINavigationController(rootViewController: NextViewController()),
        ]
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
