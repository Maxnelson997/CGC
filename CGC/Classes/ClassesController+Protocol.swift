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
    
    func addClass(clas: SemesterClass) {
        DispatchQueue.main.async {
            self.classes.append(clas)
            let newIndexPath = IndexPath(row: self.classes.count - 1, section: 0)
            self.tableView.beginUpdates()
            
            self.tableView.insertRows(at: [newIndexPath], with: .right)
            self.tableView.endUpdates()
            self.footerView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
    }

}
