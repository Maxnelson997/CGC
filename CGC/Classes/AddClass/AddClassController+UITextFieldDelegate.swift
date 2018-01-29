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
        let title = NSMutableAttributedString(string: textField.text ?? "Name", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 42) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        title.append(NSMutableAttributedString(string: "\n\(grade)\n\(hour) hours", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        largeNameLabel.attributedText = title
    }
}
