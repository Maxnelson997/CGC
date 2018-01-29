//
//  AddSemesterController+Actions.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension AddSemesterController: SelectIconDelegate {
    @objc func handleSave() {
        var newSemester:Semester?
        var semesterImage = UIImage()
        guard var title = nameTextField.text else { return }
        if title.count == 0 { title = "Spring 18"}
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        if isEdit {
            newSemester = semesterToEdit
            newSemester?.title = title
        } else {
            if !iconSelected {
                semesterImage = DefaultValues.shared.icon
            }
            newSemester = Semester(icon: semesterImage, title: title, classes: [])
        }

        
        if let newSemester = newSemester {
            dismiss(animated: true) {
                if self.isEdit {
                    guard let index = self.index else { return }
                    self.delegate?.addSemester(semester: newSemester, at: index)
                } else {
                    self.delegate?.addSemester(semester: newSemester, at: -1)
                }
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


