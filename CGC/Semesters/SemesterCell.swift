//
//  SemesterCell.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class SemesterCell: UITableViewCell {

    var sel:Bool = false
    var delegate:IndexDelegate?
    
    @objc func handleEdit() {
        sel = !sel
        delegate?.setSemesterSelected(at: tag - 1)
        let fill:(UIColor,UIColor) = sel ? (.appleBlue,.appleBlue) : (UIColor.black.withAlphaComponent(0.8),.clear)
        let selectedViewFill:UIColor = sel ? UIColor.appleBlue.withAlphaComponent(0.2) : .clear
        UIView.animate(withDuration: 0.1, animations: {
            self.editButton.backgroundColor = fill.1
            self.editButton.layer.borderColor = fill.0.cgColor
            self.selectedView.backgroundColor = selectedViewFill
        })
 
    }
    
    var isEditingCell: Bool? {
        didSet {
            guard let b = isEditingCell else { return }
            let width:CGFloat = b ? 70 : 20
            let delay:CGFloat = CGFloat(tag)/70 + 0.1
            UIView.animate(withDuration: 0.4, delay: TimeInterval(delay), usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.editButton.transform = CGAffineTransform(translationX: width, y: 0)
                self.icon.transform = CGAffineTransform(translationX: width-20, y: 0)
                self.infoLabel.transform = CGAffineTransform(translationX: width-20, y: 0)
//                self.openButton.transform = CGAffineTransform(translationX: width-20, y: 0)
            }, completion: nil)
        }
    }

    var semester:Semester? {
        didSet {
            guard let s = semester else { return }
            icon.setImage(s.icon, for: .normal)
            sel = s.selected
            self.selectedView.backgroundColor = .clear
            self.editButton.backgroundColor = .clear
            self.editButton.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
            let title = NSMutableAttributedString(string: s.title, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            let info = NSMutableAttributedString(string: "\n\(s.GPALabel)\n\(s.creditHours)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)! ,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
            title.append(info)
            infoLabel.attributedText = title
        }
    }
    
    let icon:UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.layer.cornerRadius = 15
        return button
    }()
    
    
    let infoLabel:TabbedLabel = {
        let label = TabbedLabel()
        let title = NSMutableAttributedString(string: "Jane Smith", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18) ?? UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.black])
        let info = NSMutableAttributedString(string: "\nSemesters: 5\nClasses: 21\nCredit Hours: 68", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        label.attributedText = title
        label.numberOfLines = 0
        return label
    }()
    
    let openButton:UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
//        b.backgroundColor = .grayButton
        b.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        b.setTitle("open", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.init(name: "Futura-Bold", size: 12)
        return b
    }()
    
    lazy var editButton:UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
        b.backgroundColor = .clear
        b.layer.borderWidth = 4
        b.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        b.addTarget(self, action: #selector(self.handleEdit), for: [.touchUpInside])
        return b
    }()
    
    let selectedView:UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = false
        return v
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(editButton)
        addSubview(icon)
        addSubview(infoLabel)
        addSubview(openButton)
        addSubview(selectedView)

        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 50, height: 50)
        infoLabel.anchor(top: topAnchor, left: icon.rightAnchor, bottom: bottomAnchor, right: openButton.leftAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 2, paddingRight: 10, width: 0, height: 0)
        openButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 50, height: 20)
        openButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        editButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -50, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectedView.anchorEntireView(to: self)
        
        print("cell created")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
