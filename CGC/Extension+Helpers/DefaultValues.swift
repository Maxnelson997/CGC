//
//  DefaultValues.swift
//  CGC
//
//  Created by Max Nelson on 1/29/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class DefaultValues {
    
    static let shared = DefaultValues()
    
    var icon = #imageLiteral(resourceName: "s50")
    var semesterTitle = "Spring 18"
    var themeColor:UIColor = .gitCommitGreen
    var themeTitleColor:UIColor = .black
    var themeWasChanged:Bool = false
    var isUserFreemium:Bool = true
    var colors:[UIColor] = [
        .appleBlue,
        .aplGreen,
        UIColor.yellow.withAlphaComponent(0.8),
        .grayButton,
        .orangeTheme,
        .tealColor,
        .radicalRed,
        .gotGreen,
        .butBlue,
        .poppinPurple,
        .gitCommitGreen,
        .garbageGolden
    ]
    var theme:ThemeColor?
    
    //magic code right here
    static func setAppIcon(name: String?) {
        
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        guard let name = name else {
            // Reset to default
            UIApplication.shared.setAlternateIconName(nil)
            return
        }
        
        UIApplication.shared.setAlternateIconName(name){ error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
//    OLDAVATAR
//    YOUNGAVATAR
//    PRO
//    AUDIO
//    ANIMALS
//    SPACE_ONE
//    SPACE_TWO
//    SPACE_THREE
//    EDU_SUBJECTS
//    EDU_DOPE
//    EDUCATION
//    EMOJI
    
    let OLDAVATAR:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 24 {
            arr.append(UIImage(named: "ava\(String(describing: i))")!)
        }
        return arr
    }()
    
    let YOUNGAVATAR:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 16 {
            arr.append(UIImage(named: "av\(String(describing: i))")!)
        }
        return arr
    }()
    
    let PRO:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 31 {
            arr.append(UIImage(named: "pro\(String(describing: i))")!)
        }
        return arr
    }()
    
    let AUDIO:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 35 {
            arr.append(UIImage(named: "ad\(String(describing: i))")!)
        }
        return arr
    }()
    
    let ANIMALS:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 50 {
            arr.append(UIImage(named: "a\(String(describing: i))")!)
        }
        return arr
    }()
    
    let SPACE_ONE:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 25 {
            arr.append(UIImage(named: "s\(String(describing: i))")!)
        }
        return arr
    }()
    
    let SPACE_TWO:[UIImage] = {
        var arr = [UIImage]()
        for i in 25 ..< 56 {
            arr.append(UIImage(named: "s\(String(describing: i))")!)
        }
        return arr
    }()
    
    let SPACE_THREE:[UIImage] = {
        var arr = [UIImage]()
        for i in 56 ..< 79 {
            arr.append(UIImage(named: "s\(String(describing: i))")!)
        }
        return arr
    }()
    
    let EDU_SUBJECTS:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 38 {
            arr.append(UIImage(named: "e\(String(describing: i))")!)
        }
        return arr
    }()
    
    let EDU_DOPE:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 35 {
            arr.append(UIImage(named: "f\(String(describing: i))")!)
        }
        return arr
    }()
    
    let EDUCATION:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 17 {
            arr.append(UIImage(named: "u\(String(describing: i))")!)
        }
        return arr
    }()
    
    let EMOJI:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 50 {
            arr.append(UIImage(named: "emoj\(String(describing: i))")!.withRenderingMode(.alwaysTemplate))
        }
        return arr
    }()
    
    let ICON_OPTIONS:[UIImage] = {
        var arr = [UIImage]()
        for i in 0 ..< 8 {
            arr.append(UIImage(named: "option\(String(describing: i))")!)
        }
        return arr
    }()
    
    static func ResetLaunch() {
        UserDefaults.standard.set(false, forKey: "launchedBefore")
    }
    
    static func CheckLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            return false //has launched
        }
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        return true //hasn't launched, first launch.
    }
    
    
    


}
