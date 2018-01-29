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
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newSemester = NSEntityDescription.insertNewObject(forEntityName: "Semester", into: context) as! Semester

        var semesterImage = UIImage()
        guard var title = nameTextField.text else { return }
        if title.count == 0 { title = "Spring 18"}
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        if !iconSelected && !isEdit {
            semesterImage = DefaultValues.shared.icon
        }
      
        let imageData = UIImagePNGRepresentation(semesterImage)
        newSemester.icon = imageData
        newSemester.title = title
        newSemester.selected = false
    
        //perform the save
        do {
            try context.save()
            //successfuly saved to coredata
            dismiss(animated: true) {
                self.delegate?.addSemester(semester: newSemester, at: self.index)
            }
        } catch let error {
            print("failed to save company context in coredata:",error)
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


