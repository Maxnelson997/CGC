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
        for clas in classes {
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
        if classes.count >= 4 && DefaultValues.shared.isUserFreemium {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
            let UPC = UpgradeController(collectionViewLayout: layout)
            let UPC_NAV = CustomNavController(rootViewController: UPC)
            self.navigationController?.present(UPC_NAV, animated: true, completion: nil)
        } else {
            let ACC = AddClassController()
            ACC.delegate = self
            ACC.semester = semester
            let ACC_NAV = CustomNavController(rootViewController: ACC)
            present(ACC_NAV, animated: true, completion: nil)
        }
    }
    
    @objc func handleDelete() {
        guard self.indexes.count > 0 else { return }
        //filter out selected classes. obliterate them
        let classesToDelete = classes.filter { $0.selected }
        let context = CoreDataManager.shared.persistentContainer.viewContext
        for clas in classesToDelete {
            context.delete(clas)
        }
        //filter to only selected classes for temp storage. core data has been saved.
        classes = classes.filter { !$0.selected }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .right)
        tableView.endUpdates()
        handleEdit()
        do {
            try context.save()
        } catch let err {
            print("failed to save context with removed semester:",err)
        }
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
        let semesterCreditHours:Int = Int(CoreDataManager.shared.getSemesterClassesCreditHours(semester: semester))
        let title = NSMutableAttributedString(string: "\(String(describing: semester.title!)) stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nClasses: \(String(describing: self.classes.count))\nCredit Hours: \(semesterCreditHours)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)! ,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        userInfoLabel.attributedText = title
    }
    
    func setSemesterGPA() {
        guard let semester = semester else { return }
        let semesterGPA = CoreDataManager.shared.getSemesterGPA(semester: semester)
        let gpa = String(format: "%.2f", semesterGPA)
        let title = NSMutableAttributedString(string: gpa, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 50)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        GPALabel.attributedText = title
    }

}

