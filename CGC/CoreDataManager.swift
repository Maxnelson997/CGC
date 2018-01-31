//
//  CoreDataManager.swift
//  CGC
//
//  Created by Max Nelson on 1/29/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import CoreData
import UIKit

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CGC")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed: \(err)")
            }
        }
        return container
    }()
    

    func fetchSemesters() -> [Semester] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Semester>(entityName: "Semester")
        
        do {
            let semesters = try context.fetch(fetchRequest)
            return semesters
        } catch let error {
            print("failed to fetch semesters from core data:",error)
            return []
        }
    }
    
    func fetchAllClasses() -> [SemesterClass] {
        var classes = [SemesterClass]()
        let semesters = fetchSemesters()
        for semester in semesters {
            if let semesterClasses = semester.semesterClasses?.allObjects as? [SemesterClass] {
                for clas in semesterClasses {
                    classes.append(clas)
                }
            }
        }
        return classes
    }
    
    //get credit hours for this semester
    func getSemesterClassesCreditHours(semester: Semester) -> Double {
        guard let semesterClasses = semester.semesterClasses?.allObjects as? [SemesterClass] else { return 0 }
        var creditHours:Double = 0
        for c in semesterClasses {
            creditHours += c.creditHours
        }
        return creditHours
    }

    //get gpa for this semester
    func getSemesterGPA(semester: Semester) -> Double {
        let pointsEarned = getSemesterPoints(semester: semester)
        let gpa = pointsEarned / getSemesterClassesCreditHours(semester: semester)
        return gpa.isNaN ? 0 : gpa
    }
    
    func getClassCount(for semester: Semester) -> Int {
        guard let semesterClasses = semester.semesterClasses?.allObjects as? [SemesterClass] else { return 0 }
        return semesterClasses.count
    }
    
    func getSemesterPoints(semester: Semester) -> Double {
        guard let semesterClasses = semester.semesterClasses?.allObjects as? [SemesterClass] else { return 0 }
        var pointsEarned:Double = 0.0
        if semesterClasses.count == 0 { return 0 }
        for c in semesterClasses {
            pointsEarned += c.creditHours * getClassGPA(clas: c)
        }
        return pointsEarned
    }
    
    //get points for this class
    func getClassPoints(clas: SemesterClass) -> Double {
        guard let grade = clas.grade else { return 0 }
        guard let points = letters[grade] else { return 0 }
        return points
    }
    
    //get gpa for this class
    func getClassGPA(clas: SemesterClass) -> Double {
        guard let grade = clas.grade else { return 0 }
        return letters[grade]!
    }
    
    //clear all semesters
    //remember predicates. maybe delete by year etc.
    func clearSemesters() {
        let context = persistentContainer.viewContext
        do {
            let semesters = fetchSemesters()
            semesters.forEach { (semester) in
                context.delete(semester)
            }
            try context.save()
        } catch let err {
            print("error saving/removing/deleting semesters in/from core data:",err)
        }
    }

    
    func clearClasses() {
        let context = persistentContainer.viewContext
        do {
            let classes = fetchAllClasses()
            classes.forEach { (clas) in
                context.delete(clas)
            }
            try context.save()
        } catch let err {
            print("error saving/removing/deleting classes in/from core data:",err)
        }
    }

    //create a semester class and store in core data
    func createSemesterClass(title: String, icon: UIImage, grade: String, creditHours: Double, semester: Semester) -> (SemesterClass?, Error?) {
        
        let context = persistentContainer.viewContext
        let semesterClass = NSEntityDescription.insertNewObject(forEntityName: "SemesterClass", into: context) as! SemesterClass
        semesterClass.title = title
        semesterClass.icon = UIImagePNGRepresentation(icon)
        semesterClass.grade = grade
        semesterClass.creditHours = creditHours
        semesterClass.semester = semester
        do {
            try context.save(); return (semesterClass, nil)
        } catch let err {
            print("failed to add semester class to core data",err); return (nil, err)
        }
    }
    
    //create a semester and store in core data
    func createSemester(title: String, icon: UIImage) -> (Semester?, Error?) {
        let context = persistentContainer.viewContext
        let semester = NSEntityDescription.insertNewObject(forEntityName: "Semester", into: context) as! Semester
        semester.icon = UIImagePNGRepresentation(icon)
        semester.title = title
        do {
            try context.save()
            return (semester, nil)
        } catch let err {
            print("failed to add semester class to core data",err); return (nil, err)
        }
    }
    
    func deleteClasses(classes: [SemesterClass]) {
        let context = persistentContainer.viewContext
        for clas in classes {
            context.delete(clas)
        }
        do {
            try context.save()
        } catch let err {
            print("error deleting classes from coredata:",err)
        }
    }
    
    func deleteSemesters(semesters: [Semester]) {
        let context = persistentContainer.viewContext
        for s in semesters {
            context.delete(s)
        }
        do {
            try context.save()
        } catch let err {
            print("error deleting semesters from coredata:",err)
        }
    }

}

extension CoreDataManager {
    //theme stuff
    func saveTheme(index: Int, black: Int) {
        let context = persistentContainer.viewContext
        if let t = DefaultValues.shared.theme {
            //update
            t.colorIndex = Int16(index)
            t.titleColorIndex = Int16(black)
        } else {
            //new object
            let theme = NSEntityDescription.insertNewObject(forEntityName: "ThemeColor", into: context) as! ThemeColor
            theme.colorIndex = Int16(index)
            theme.titleColorIndex = Int16(black)
        }
        
        do {
            try context.save()
        } catch let err {
            print("failed to save theme color index in core data",err)
        }
    }

    func getTheme() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ThemeColor>(entityName: "ThemeColor")
        do {
            let theme = try context.fetch(fetchRequest)
            let t = theme.first
            guard let index = t?.colorIndex else { return }
            guard let black = t?.titleColorIndex else { return }

            let colorIndex = Int(index)
            let titleColorIndex = Int(black)
            DefaultValues.shared.themeTitleColor = titleColorIndex == 1 ? .black : .white
            DefaultValues.shared.themeColor = DefaultValues.shared.colors[colorIndex]
            DefaultValues.shared.theme = t
            if DefaultValues.shared.themeColor.isEqual(UIColor.grayButton) { DefaultValues.shared.themeTitleColor = .appleBlue }
            (UIApplication.shared.delegate as! AppDelegate).setUITabBarTheme()
        } catch let err {
            print("failed to fetch theme color index:",err)
        }
    }
}
