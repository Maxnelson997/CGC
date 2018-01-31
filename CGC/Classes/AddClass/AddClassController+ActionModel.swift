//
//  AddClassController+Action.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension AddClassController: SelectIconDelegate {
    @objc func handleSave() {
        if isEdit {
            saveClassEdit()
        } else {
            saveNewClass()
        }
    }
    
    fileprivate func saveClassEdit() {
        //redundant af. fix dis.
        var classImage = UIImage()
        if let iconImage = iconImageView.imageView?.image {
            classImage = iconImage
        }
        var title = nameTextField.text ?? ""
        if title.count == 0 { title = "class" }
        guard let hoursDouble = Double(hour) else { return }
        //
        guard let clas = classToEdit else { return }
        let context = CoreDataManager.shared.persistentContainer.viewContext
        clas.title = title
        clas.icon = UIImagePNGRepresentation(classImage)
        clas.grade = grade
        clas.creditHours = hoursDouble
        do {
            try context.save()
        } catch let err {
            print("failed to add semester class to core data",err)
        }
        dismiss(animated: true, completion: {
            self.delegate?.editClass(clas: clas)
        })
    }
    
    fileprivate func saveNewClass() {
        //see. dis redundant af. fix it.
        var classImage = UIImage()
        if let iconImage = iconImageView.imageView?.image {
            classImage = iconImage
        }
        var title = nameTextField.text ?? ""
        if title.count == 0 { title = "class" }
        guard let semester = semester else { return }
        guard let hoursDouble = Double(hour) else { return }
        //
        let newClassTuple = CoreDataManager.shared.createSemesterClass(title: title, icon: classImage, grade: grade, creditHours: hoursDouble, semester: semester)
        if let err = newClassTuple.1 {
            //tell dat user wtf is up.
            print(err)
        } else if let clas = newClassTuple.0 {
            //save
            dismiss(animated: true) {
                self.delegate?.addClass(clas: clas)
            }
        }
    }
    
    @objc func handleAddIcon() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let SIC = SelectIconController(collectionViewLayout: layout)
        SIC.delegate = self
        let SIC_NAV = CustomNavController(rootViewController: SIC)
        present(SIC_NAV, animated: true, completion: nil)
    }
    
    @objc func dismissTextField() {
        nameTextField.resignFirstResponder()
    }
    
    //protocol/Delegate method
    func chooseIcon(image: UIImage) {
        iconImageView.setImage(image, for: .normal)
        iconImageView.popAnimation()
    }
    
    //methods used to retrieve indicies for getting then setting the grade and hour on edit
    func getGradeIndex(for string:String) -> Int {
        var gradeIndex = 0
        for i in 0 ..< grades.count {
            if grades[i] == string {
                gradeIndex = i
            }
        }
        grade = grades[gradeIndex]
        return gradeIndex
    }
    
    func getHourIndex(for double:Double) -> Int {
        var hourIndex = 0
        for i in 0 ..< hours.count {
            if Double(hours[i]) == double {
                hourIndex = i
            }
        }
        hour = hours[hourIndex]
        return hourIndex
    }
    
}



