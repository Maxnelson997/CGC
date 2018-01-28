//
//  MainTabBarController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        setupViewControllers()
        delegate = self
    }
    
    let semestersController = SemestersController()
    let settingsController = SettingsController()
    
    func setupViewControllers() {
        let semestersNavController = templateNavController(rootViewController: semestersController, unselectedImage: #imageLiteral(resourceName: "semesters"), selectedImage: #imageLiteral(resourceName: "semesters"))
        let settingsNavController = templateNavController(rootViewController: settingsController, unselectedImage: #imageLiteral(resourceName: "settings"), selectedImage: #imageLiteral(resourceName: "settings"))
    
        viewControllers = [semestersNavController, settingsNavController]
//        UITabBar.appearance().tintColor = UIColor.init(rgb: 0x00FFEB)
//        tabBar.backgroundImage = getImageWithColor(color: .clear, size: CGSize(width: 100, height: 100))
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
        }
    }
}

func templateNavController(rootViewController:UIViewController = UIViewController(), unselectedImage: UIImage = UIImage(), selectedImage: UIImage = UIImage()) -> UINavigationController {
    let viewController = rootViewController
    let navController = CustomNavController(rootViewController: viewController)
    navController.tabBarItem.image = unselectedImage
    navController.tabBarItem.selectedImage = selectedImage
    return navController
}

class CustomNavController:UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
}

