//
//  Extensions.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

//public func delay(_ seconds:Double, completion: @escaping() -> ()) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//        completion()
//    }
//}




extension UIColor {
    open class var g1:UIColor { return UIColor.init(rgb: 0x498AC3 )}
    open class var g0:UIColor { return UIColor.init(rgb: 0x8D9AFC )}
    
    
    static var sendy: UIColor { return UIColor.init(rgb: 0x00FFEB) }
    
    static var appleBlue: UIColor { return UIColor.init(rgb: 0x007AFF) }
    static var lightBlue: UIColor { return UIColor.init(rgb: 0x98FFEF) }
    static var lighterBlue: UIColor { return UIColor.init(rgb: 0xD6F6FF) }
    static var astronautBlue: UIColor { return UIColor.init(rgb: 0x58B4D0) }
    static var aplGreen: UIColor { return UIColor.init(rgb: 0x70EC89) }
    static var ppBlue: UIColor { return UIColor.init(rgb: 0x9BFCF3) }
    static var alienRed: UIColor { return UIColor.init(rgb: 0xCF5861) }
    static var grayButton: UIColor { return UIColor.init(rgb: 0xEFEFF4) }
    static var yellowBG: UIColor { return UIColor.init(rgb: 0xBCFF43) }
    static var purpleBG: UIColor { return UIColor.init(rgb: 0x6B22FF) }
    static var blackPointEight: UIColor { return UIColor.black.withAlphaComponent(0.8) }
    
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    static let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)

    static var orangeTheme: UIColor { return UIColor.init(rgb: 0xF3902A) }
    static var radicalRed: UIColor { return UIColor.init(rgb: 0xE44246) }
    static var gotGreen: UIColor { return UIColor.init(rgb: 0x90FA5D) }
    static var butBlue: UIColor { return UIColor.init(rgb: 0x3898FC) }
    static var poppinPurple: UIColor { return UIColor.init(rgb: 0xD2277E) }
    
    
    

//    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
    
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func rgb(red: CGFloat, green:CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue:UIColor = .rgb(red: 17, green: 154, blue: 237)
    
}

extension UIView {
    
    func popAnimation() {
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func anchorEntireView(to: UIView, withInsets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: to.leftAnchor, constant: withInsets.left).isActive = true
        self.rightAnchor.constraint(equalTo: to.rightAnchor, constant: -1*(withInsets.right)).isActive = true
        self.topAnchor.constraint(equalTo: to.topAnchor, constant: withInsets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -1*(withInsets.bottom)).isActive = true
    }
    
    func showMessage(title:String, textAlignment:NSTextAlignment = .center) {
        DispatchQueue.main.async {
            let container = UILabel()
            let savedLabel = UILabel()
            savedLabel.text = title
            savedLabel.font = UIFont.init(name: "Futura-Bold", size: 25)
            savedLabel.adjustsFontSizeToFitWidth = true
            savedLabel.textColor = .white
            savedLabel.numberOfLines = 0
            savedLabel.backgroundColor = .clear
            container.backgroundColor = UIColor(white: 0, alpha: 0.3)
            savedLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width*0.5, height: self.frame.height*0.18)
            savedLabel.center = self.center
            container.frame = CGRect(x: 0, y: 0, width: self.frame.width*0.6, height: self.frame.height*0.2)
            container.center = self.center
            savedLabel.textAlignment = textAlignment
            savedLabel.layer.cornerRadius = 12
            savedLabel.layer.masksToBounds = true
            container.layer.cornerRadius = 12
            container.layer.masksToBounds = true
            self.addSubview(container)
            self.addSubview(savedLabel)
            savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
            container.layer.transform = CATransform3DMakeScale(0, 0, 0)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                container.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: { (completed) in
                //animation in complete
                UIView.animate(withDuration: 0.4, delay: 1.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    savedLabel.layer.transform = CATransform3DMakeScale(0.4, 0.1, 0.1)
                    savedLabel.alpha = 0
                    container.layer.transform = CATransform3DMakeScale(0.4, 0.1, 0.1)
                    container.alpha = 0
                }, completion: { (completed) in
                    //animation out complete
                    savedLabel.removeFromSuperview()
                    container.removeFromSuperview()
                })
            })
        }
    }
    
    
}

extension Bool {
    func toNSData() -> Data {
        
        var myInt:Int?
        if self == true {
            myInt = 1
        } else {
            myInt = 0
        }
        
        let myIntData = Data(bytes: &myInt, count: MemoryLayout.size(ofValue: myInt))
        return myIntData
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
}


enum ImageCategory: String {
    case any //used to fetch image from any category randomly
    
    case tech
    case nature
    case people
    case industrial
    
    static let all = [tech, nature]
}

extension UIImage {
    
    
    /**
     Creates the UIImageJPEGRepresentation out of an UIImage
     @return Data
     */
    
    func generateJPEGRepresentation(size:CGSize) -> Data {
        
        let newImage = self.copyOriginalImage(size:size)
        let newData = UIImageJPEGRepresentation(newImage, 1)
        
        return newData!
    }
    
    /**
     Copies Original Image which fixes the crash for extracting Data from UIImage
     @return UIImage8
     */
    
    private func copyOriginalImage(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
}
