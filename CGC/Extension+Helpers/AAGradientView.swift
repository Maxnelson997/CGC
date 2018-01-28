//
//  AAGradient.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class AAGradientView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    
    init(frame: CGRect = .zero, colors:[UIColor], locations:[NSNumber] = [0.0, 1.2]) {
        super.init(frame: frame)
        if frame == .zero { self.translatesAutoresizingMaskIntoConstraints = false }
        self.colors = [colors[0].cgColor, colors[1].cgColor]
        self.locations = locations
        phaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layerColors:[CGColor] {
        set {
            if let laya = self.layer as? CAGradientLayer {
                laya.colors = newValue
                laya.locations = [0.0, 1]
            }
        }
        get {
            return [ UIColor(rgb: 0x82D15C).cgColor, UIColor(rgb: 0x11C2D3).cgColor ]
        }
    }
    
    var colors:[CGColor] = [ UIColor(rgb: 0x82D15C).cgColor, UIColor(rgb: 0x11C2D3).cgColor ]
    var locations:[NSNumber] = [0.0, 1.2]
    // MARK: - phase two initialization
    func phaseTwo() {
        translatesAutoresizingMaskIntoConstraints = false
        if let laya = self.layer as? CAGradientLayer {
            laya.colors = colors
            laya.locations = locations
        }
        //        self.addDropShadowToView()
    }
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}


