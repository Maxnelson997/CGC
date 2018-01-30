//
//  SemestersController+Action.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension SemestersController {
    //Actions
    @objc func handleEdit() {
        if isEditingSemesters {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.handleEdit))
            navigationItem.rightBarButtonItem = .none
        }
        indexes = []
        for var sem in semesters {
            sem.selected = false
        }
        isEditingSemesters = !isEditingSemesters
        let alpha:CGFloat = isEditingSemesters ? 1 : 0
        UIView.animate(withDuration: 0.3) {
            self.footerView.alpha = alpha
        }
        tableView.reloadData()
    }

    @objc func handleAdd() {
        let ASC = AddSemesterController()
        ASC.delegate = self
        let ASC_NAV = CustomNavController(rootViewController: ASC)
        present(ASC_NAV, animated: true, completion: nil)
    }
    
    @objc func handleDelete() {
        guard self.indexes.count > 0 else { return }
        let semestersToDelete = semesters.filter { $0.selected }
        //delete semesters from core data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        for s in semestersToDelete {
            context.delete(s)
        }
        
        semesters = semesters.filter { !$0.selected }
        //filter out selected semesters. obliterate them.
       
        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .right)
        tableView.endUpdates()
        handleEdit()
        calculateAllInfo()
        
        do {
            try context.save()
        } catch let err {
            print("failed to save context with removed semester:",err)
        }
    }
    
    
    @objc func handleDisable() {
        print("trying to disable")
    }
    
    //ViewModel
    func calculateAllInfo() {
        calculateGlobalGPA()
        calculateGlobalStats()
    }
    
    func calculateGlobalGPA() {
        let pointsCredits = getPointsCredits()
        var gpa = pointsCredits.0 / pointsCredits.1
        if gpa.isNaN { gpa = 0 }
        let gpaString = String(format: "%.2f", gpa)
        
        let GPAtitle = NSMutableAttributedString(string: gpaString, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 40)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        GPAtitle.append(NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        GPALabel.attributedText = GPAtitle
    }
    
    func calculateGlobalStats() {
        var classCount = 0
        var creditHoursCount = 0
        for s in semesters {
            classCount += CoreDataManager.shared.getClassCount(for: s)
            creditHoursCount += Int(CoreDataManager.shared.getSemesterClassesCreditHours(semester: s))
        }

        let title = NSMutableAttributedString(string: "Your Stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nSemesters: \(semesters.count)\nClasses: \(classCount)\nCredit Hours: \(creditHoursCount)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        userInfoLabel.attributedText = title
        tableView.reloadData()
    }
    
     func getPointsCredits() -> (Double,Double) {
        var totalPointsEarned:Double = 0.0
        var totalCreditsEarned:Double = 0.0
        
        semesters.forEach { (semester) in
            totalPointsEarned += CoreDataManager.shared.getSemesterPoints(semester: semester)
            totalCreditsEarned += CoreDataManager.shared.getSemesterClassesCreditHours(semester: semester)
        }
        
        return (totalPointsEarned, totalCreditsEarned)
    }

}

let letters:[String:Double] = [
    "A+":4.0,
    "A":4.0,
    "A-":3.7,
    "B+":3.33,
    "B":3.00,
    "B-":2.7,
    "C+":2.3,
    "C":2.0,
    "C-":1.7,
    "D+":1.3,
    "D":1.0,
    "D-":0.70,
    "F":0]

