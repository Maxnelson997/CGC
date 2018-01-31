//
//  CGCTextField.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class CGCTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func phaseTwo() {
        backgroundColor = .blackPointEight
        textColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        font = UIFont.init(name: "Futura", size: 16)
    }
}


