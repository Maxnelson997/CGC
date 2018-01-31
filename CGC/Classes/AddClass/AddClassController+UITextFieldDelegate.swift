//
//  AddClassController+TextFieldDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension AddClassController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var text = nameTextField.text ?? ""
        if text.count == 0 { text = "Class" }
        var fontSize:CGFloat = 42
        if text.count > 6 {
            fontSize = 25
        }
        let title = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        title.append(NSMutableAttributedString(string: "\n\(grade)\n\(hour) hours", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        largeNameLabel.attributedText = title
    }
}


