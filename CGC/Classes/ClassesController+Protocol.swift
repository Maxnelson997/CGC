//
//  ClassesController+Protocol.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

protocol AddClassDelegate {
    func addClass(clas: SemesterClass)
    func editClass(clas: SemesterClass)
}

extension ClassesController: IndexDelegate, AddClassDelegate {
    func setSemesterSelected(at index:Int) {
        print("selected index:",index)
        if index <= classes.count {
            classes[index].selected = !classes[index].selected
            if classes[index].selected {
                indexes.append(IndexPath(row: index, section: 0))
            } else {
                indexes = indexes.filter { $0.row != index }
            }
        } else {
            assert(false, "out of range")
        }
    }
    func editClass(clas: SemesterClass) {
        DispatchQueue.main.async {
            if let row = self.classes.index(of: clas) {
                let reloadIndexPath = IndexPath(row: row, section: 0)
                self.tableView.reloadRows(at: [reloadIndexPath], with: .right)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
    }
    func addClass(clas: SemesterClass) {
        DispatchQueue.main.async {
//            if let classIndex = classIndex, classIndex != -1 {
//                self.classes[classIndex] = clas
//            } else {
//
//            }
            self.classes.append(clas)
//            self.semester?.classes = self.classes
//            guard let semester = self.semester else { return }
//            guard let index = self.index else { return }
//            self.delegate?.saveSemester(semester: semester, at: index)
            let newIndexPath = IndexPath(row: self.classes.count - 1, section: 0)
            self.tableView.insertRows(at: [newIndexPath], with: .right)
            self.footerView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
    }


}
