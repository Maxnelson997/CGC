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
        var classImage = UIImage()
        if let iconImage = iconImageView.imageView?.image {
            classImage = iconImage
        }
        var title = nameTextField.text ?? ""
        if title.count == 0 { title = "class" }
        guard let hoursDouble = Double(hour) else { return }
        let newClass = SemesterClass(icon: classImage, title: title, grade: grade, creditHours: hoursDouble)
        dismiss(animated: true) {
            if self.isEdit {
                guard let index = self.index else { return }
                self.delegate?.addClass(clas: newClass, at: index)
            } else {
                self.delegate?.addClass(clas: newClass, at: -1)
            }
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



