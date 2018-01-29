//
//  SemesterClass.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

struct SemesterClass {
    let icon:UIImage
    let title:String
    let grade:String
    let creditHours:Double
    var selected:Bool = false
    
    init(icon:UIImage, title:String, grade:String, creditHours:Double) {
        self.icon = icon
        self.title = title
        self.grade = grade
        self.creditHours = creditHours
    }
    
    func getClassPoints() -> Double {
        guard let points = letters[grade] else { return 0.0 }
        return points
    }
    
    func getClassGPA() -> Double {
        return letters[grade]!
    }
}
