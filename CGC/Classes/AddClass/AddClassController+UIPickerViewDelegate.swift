//
//  AddClassController+PickerViewDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension AddClassController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return grades.count
        }
        return hours.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var text = ""
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        if component == 0 {
            text = " " + grades[row]
            paragraphStyle.alignment = .left
        } else {
            text = hours[row]
        }
        return NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 16)!, NSAttributedStringKey.paragraphStyle: paragraphStyle])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            grade = grades[row]
        } else {
            hour = hours[row]
        }
        var text = nameTextField.text ?? ""
        if text.count == 0 { text = "Class" }
        var fontSize:CGFloat = 42
        if text.count > 8 {
            fontSize = 25
        }
        let title = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        title.append(NSMutableAttributedString(string: "\n\(grade)\n\(hour) hours", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        largeNameLabel.attributedText = title
    }
}
