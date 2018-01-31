//
//  AddSemesterController+Actions.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import CoreData

extension AddSemesterController: SelectIconDelegate {
    
    @objc func handleSave() {
        if isEdit {
            saveClassEdit()
        } else {
            saveNewClass()
        }
    }

    fileprivate func saveClassEdit() {
        //redundant af. fix dis.
        var semesterImage = UIImage()
        guard var title = nameTextField.text else { return }
        if title.count == 0 { title = "Spring 18"}
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        if !iconSelected && !isEdit {
            semesterImage = DefaultValues.shared.icon
        }
        //update
        guard let semester = semesterToEdit else { return }
        let context = CoreDataManager.shared.persistentContainer.viewContext
        semester.icon = UIImagePNGRepresentation(semesterImage)
        semester.title = title
        semester.selected = false
        //save
        do {
            try context.save()
        } catch let err {
            print("failed to add semester class to core data",err)
        }
        dismiss(animated: true, completion: {
            self.delegate?.editSemester(semester: semester)
        })
    }

    fileprivate func saveNewClass() {
        //redundant af. fix dis.
        var semesterImage = UIImage()
        guard var title = nameTextField.text else { return }
        if title.count == 0 { title = "Spring 18"}
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        if !iconSelected && !isEdit {
            semesterImage = DefaultValues.shared.icon
        }
        //create new semester object and stuff in core data
        let newClassTuple = CoreDataManager.shared.createSemester(title: title, icon: semesterImage)
        if let err = newClassTuple.1 {
            //tell dat user wtf is up.
            print(err)
        } else if let semester = newClassTuple.0 {
            //save
            dismiss(animated: true) {
                self.delegate?.addSemester(semester: semester)
            }
        }
    }


    @objc func handleAddIcon() {
        iconSelected = true
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
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
    func getIndexOfSeason() -> Int {
        var indexOfSeason = 0
        for i in 0 ..< seasons.count {
            if seasons[i] == season {
                indexOfSeason = i
            }
        }
        return indexOfSeason
    }
    
    func getIndexOfYear() -> Int {
        var indexOfYear = 0
        for i in 0 ..< years.count {
            if years[i] == year {
                indexOfYear = i
            }
        }
        return indexOfYear
    }
    
}


