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
        var amt:CGFloat = 16
        if UIDevice.current.model == "iPad" {
            amt = 0
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                amt = 4
            case 1334:
                print("iPhone 6/6S/7/8")
                amt = 4
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                amt = 10
            case 2436:
                print("iPhone X")
                amt = 16
            default:
                print("unknown")
            }
        }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: amt, left: 0, bottom: amt * -1, right: 0)
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if DefaultValues.shared.themeTitleColor == .white {
             return .lightContent
        }
        return .default
    }
}



