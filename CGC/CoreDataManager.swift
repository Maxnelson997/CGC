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
            print("failed to fetch companies from core data:",error)
            return []
        }
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
        return pointsEarned / getSemesterClassesCreditHours(semester: semester)
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
    
    func createSemester(title: String, icon: UIImage) -> (Semester?, Error?) {
        let context = persistentContainer.viewContext
        let semester = NSEntityDescription.insertNewObject(forEntityName: "Semester", into: context) as! Semester
        semester.icon = UIImagePNGRepresentation(icon)
        semester.title = title
        do {
            try context.save(); return (semester, nil)
        } catch let err {
            print("failed to add semester class to core data",err); return (nil, err)
        }
    }
    

}
