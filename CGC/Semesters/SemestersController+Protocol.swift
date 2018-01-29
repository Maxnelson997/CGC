//
//  SemestersController+Delegate.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

protocol IndexDelegate {
    func setSemesterSelected(at index:Int)
}

protocol AddSemesterDelegate {
    func addSemester(semester: Semester)
}

protocol UpdateSemesterDelegate {
    func saveSemester(semester: Semester)
}

extension SemestersController: IndexDelegate, AddSemesterDelegate, UpdateSemesterDelegate {
    func setSemesterSelected(at index:Int) {
        print("selected index:",index)
        if index <= semesters.count {
            semesters[index].selected = !semesters[index].selected
            if semesters[index].selected {
                indexes.append(IndexPath(row: index, section: 0))
            } else {
                indexes = indexes.filter { $0.row != index }
            }
        } else {
            assert(false, "out of range")
        }
    }
    
    func addSemester(semester: Semester) {
        DispatchQueue.main.async {
            self.semesters.append(semester)
            let newIndexPath = IndexPath(row: self.semesters.count - 1, section: 0)
            self.tableView.beginUpdates()
            
            self.tableView.insertRows(at: [newIndexPath], with: .right)
            self.tableView.endUpdates()
            self.footerView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
    }
    
    func saveSemester(semester: Semester) {
        print("old")
        semesters.forEach { (s) in
            print(s)
        }

        for i in 0 ..< semesters.count {
            if semesters[i].title == semester.title {
                //replace it bit.
                semesters[i] = semester
            }
        }

        print("new")
        semesters.forEach { (s) in
            print(s)
        }
        
        calculateAllInfo()
    }
}
