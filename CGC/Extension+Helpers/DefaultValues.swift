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
    
    var icon = #imageLiteral(resourceName: "saturn")
    var semesterTitle = "Spring 18"
    var themeColor:UIColor = .aplGreen
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
        .poppinPurple
    ]
    var theme:ThemeColor?

}
