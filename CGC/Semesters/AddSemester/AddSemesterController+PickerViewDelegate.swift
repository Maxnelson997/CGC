//
//  AddSemesterController+PickerViewDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/27/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension AddSemesterController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return seasons.count
        }
        return years.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var text = years[row]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        if component == 0 {
            text = " " + seasons[row]
            paragraphStyle.alignment = .left
        }
        return NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 16)!, NSAttributedStringKey.paragraphStyle: paragraphStyle])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            season = seasons[row]
        } else {
            year = years[row]
        }
        let title = NSMutableAttributedString(string: season, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 42) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        let info = NSMutableAttributedString(string: "\n\(year)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        largeNameLabel.attributedText = title
        nameTextField.text = "\(season) \(year)"
        nameTextField.attributedPlaceholder = NSAttributedString(string: "\(season) \(year)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 14)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.6, alpha: 1)])
    }
}
