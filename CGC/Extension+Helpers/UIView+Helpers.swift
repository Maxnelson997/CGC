//
//  Helpers.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit



class TabbedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 16, 0, 0)))
    }
}


class TabbedRightLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 0, 0, 16)))
    }
}

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var size:CGFloat = 12
    var insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    init(text:String, size:CGFloat = 12, alignment:NSTextAlignment = .left, font:fontType = .bold, insets:UIEdgeInsets? = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        super.init(frame: .zero)
        if let insets = insets {
            self.insets = insets
        }
        self.size = size
        textAlignment = alignment
        var fontName = "Futura-Bold"
        if font == .regular {
            fontName = "Futura"
        }
        attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font:UIFont.init(name: fontName, size: size)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        numberOfLines = 0
    }
    
    override var text: String? {
        didSet {
            attributedText = NSMutableAttributedString(string: text!, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: size)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

class InsetLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var size:CGFloat = 12
    var insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    init(text:String, size:CGFloat = 12, alignment:NSTextAlignment = .left, font:fontType = .bold, insets:UIEdgeInsets? = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.textAlignment = alignment
        self.size = size
        var fontName = "Futura-Bold"
        if font == .regular {
            fontName = "Futura"
        }
        if let insets = insets {
            self.insets = insets
        }
        self.font = UIFont.init(name: fontName, size: size)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

extension UITextField {
    var paddingLeft: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    var paddingRight: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

//extension UITextView {
//    var paddingLeft: CGFloat {
//        get {
//            return leftView!.frame.size.width
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
//            leftView = paddingView
//            leftViewMode = .always
//        }
//    }
//    
//    var paddingRight: CGFloat {
//        get {
//            return rightView!.frame.size.width
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
//            rightView = paddingView
//            rightViewMode = .always
//        }
//    }
//}


