//
//  ClassesController+ActionModel.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension ClassesController {
    //Actions
    @objc func handleEdit() {
        if isEditingClasses {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd)), UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))]
        } else {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.handleEdit))]
        }
        indexes = []
        for var clas in classes {
            clas.selected = false
        }
        isEditingClasses = !isEditingClasses
        let alpha:CGFloat = isEditingClasses ? 1 : 0
        UIView.animate(withDuration: 0.3) {
            self.footerView.alpha = alpha
        }
        tableView.reloadData()
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAdd() {
        let ACC = AddClassController()
        ACC.delegate = self
        let ACC_NAV = CustomNavController(rootViewController: ACC)
        present(ACC_NAV, animated: true, completion: nil)
    }
    
    @objc func handleDelete() {
        guard self.indexes.count > 0 else { return }
        //filter out selected classes. obliterate them.
        classes = classes.filter { !$0.selected }
        //overwrite semester classes
        semester?.classes = classes
        guard let semester = semester else { return }
        guard let index = index else { return }
        delegate?.saveSemester(semester: semester, at: index)
        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .right)
        tableView.endUpdates()
        handleEdit()
        calculateAllInfo()
    }
    
    @objc func handleDisable() {
        print("trying to disable")
    }
    
    //ViewModel
    func calculateAllInfo() {
        setSemesterInfo()
        setSemesterGPA()
    }
    
    func setSemesterInfo() {
        guard let semester = semester else { return }
        let title = NSMutableAttributedString(string: "\(semester.title) stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nClasses: \(semester.classes.count)\nCredit Hours: \(Int(semester.getSemesterClassesCreditHours()))", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)! ,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        userInfoLabel.attributedText = title
    }
    
    func setSemesterGPA() {
        guard let semester = semester else { return }
        let gpa = String(format: "%.2f", semester.getSemesterGPA())
        
        let title = NSMutableAttributedString(string: gpa, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 40)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        GPALabel.attributedText = title
    }

}

