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
    func addSemester(semester: Semester, at semesterIndex:Int)
}

protocol UpdateSemesterDelegate {
    func saveSemester(semester: Semester, at index: Int)
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
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let err {
            print("failed to save context with removed semester:",err)
        }
    }
    
    
    func addSemester(semester: Semester, at semesterIndex:Int) {
        DispatchQueue.main.async {
            if semesterIndex != -1 {
                //delete semester and replace in core data
                let context = CoreDataManager.shared.persistentContainer.viewContext
                context.delete(self.semesters[semesterIndex])
                do {
                    try context.save()
                } catch let err {
                    print("failed to save context with removed semester:",err)
                }
                self.semesters[semesterIndex] = semester
                self.tableView.reloadData()
            } else {
                self.semesters.append(semester)
                let newIndexPath = IndexPath(row: self.semesters.count - 1, section: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [newIndexPath], with: .right)
                self.tableView.endUpdates()
            }
            self.footerView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
    }
    
    
    func saveSemester(semester: Semester, at index: Int) {
        semesters[index] = semester
        calculateAllInfo()
    }
}
