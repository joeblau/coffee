// AppDelegate.swift
// Copyright (c) 2020 Joe Blau

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}
