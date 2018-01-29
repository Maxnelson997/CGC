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
        var semesterImage = UIImage()
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        let newSemester = Semester(icon: semesterImage, title: "\(season) \(year)", classes: [])
        dismiss(animated: true) {
            self.delegate?.addSemester(semester: newSemester)
        }
    }
    
    @objc func handleAddIcon() {
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
}


