//
//  AppDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tab = MainTabBarController()
    
    func setTheme(theme: Theme) {
        DefaultValues.shared.themeWasChanged = true
        DefaultValues.shared.themeColor = theme.color
        DefaultValues.shared.themeTitleColor = theme.titleColor
        setUITabBarTheme()
        //save it in core data
        if let index = DefaultValues.shared.colors.index(of: theme.color) {
            CoreDataManager.shared.saveTheme(index: index, black: theme.titleColor == .black ? 1 : 0)
        }
    }
    

    func setUITabBarTheme() {
        let c = DefaultValues.shared.themeColor
        let ttc = DefaultValues.shared.themeTitleColor
        UINavigationBar.appearance().barTintColor = c
        UITabBar.appearance().tintColor = c
        UITabBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: ttc]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ttc]
        UINavigationBar.appearance().tintColor = ttc
        if c.isEqual(UIColor.yellow.withAlphaComponent(0.8)) || c.isEqual(UIColor.grayButton) {
            UITabBar.appearance().tintColor = UIColor.appleBlue
            UITabBar.appearance().backgroundColor = c
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .aplGreen//.grayButton
        UITabBar.appearance().tintColor = .aplGreen
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = tab

        let backgroundGradient = AAGradientView(frame: UIScreen.main.bounds, colors: [.white, .white], locations: [-0.5, 1])
        window?.insertSubview(backgroundGradient, at: 0)
        //get theme
        CoreDataManager.shared.getTheme()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CGC")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

