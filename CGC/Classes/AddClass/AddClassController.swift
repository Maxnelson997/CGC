//
//  AddClassController.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class AddClassController: UIViewController {
    
    //pickerview data
    var grade = "A"
    var hour = "3"
    var grades:[String] = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    var hours:[String] = {
        var s = [String]()
        for i in 0 ..< 11 {
            s.append(String(describing: i))
        }
        return s
    }()
    
    var delegate:AddClassDelegate?
    
    //components
    let iconLabel = TitleLabel(text: "Icon", size: 18, alignment: .left)
    let nameLabel = TitleLabel(text: "Name", size: 18, alignment: .left)
    let seasonLabel = TitleLabel(text: "Grade", size: 18, alignment: .left)
    let yearLabel = TitleLabel(text: "Hours", size: 18, alignment: .center)
    
    lazy var iconImageView:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleAddIcon), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "addIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var largeNameLabel:TabbedRightLabel = {
        let label = TabbedRightLabel()
        let title = NSMutableAttributedString(string: "Name", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 42) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        title.append(NSMutableAttributedString(string: "\n\(grade)\n\(hour) hours", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        label.attributedText = title
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let nameTextField:CGCTextField = {
        let tf = CGCTextField()
        tf.paddingLeft = 8
        tf.attributedPlaceholder = NSAttributedString(string: "Type here or pick a season & year", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 14)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.6, alpha: 1)])
        return tf
    }()
    
    let pickerView:UIPickerView = {
        let p = UIPickerView()
        p.backgroundColor = .blackPointEight
        p.layer.cornerRadius = 8
        p.layer.masksToBounds = true
        return p
    }()
    
    var isEdit:Bool = false
    var classToEdit:SemesterClass?
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Class"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        setupCancelButton()
        setupUI()
        nameTextField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTextField)))
        
        if isEdit {
            guard let clas = classToEdit else { return }
            var gradeIndex = 0
            var hourIndex = 0
            for i in 0 ..< grades.count {
                if grades[i] == clas.grade {
                    gradeIndex = i
                }
            }
            for i in 0 ..< hours.count {
                if Double(hours[i]) == clas.creditHours {
                    hourIndex = i
                }
            }
            pickerView.selectRow(gradeIndex, inComponent: 0, animated: true)
            pickerView.selectRow(hourIndex, inComponent: 1, animated: true)
            
            navigationItem.title = "Edit Class"
            let title = NSMutableAttributedString(string: clas.title, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 42)!, NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
            title.append(NSMutableAttributedString(string: "\n\(clas.grade)\n\(clas.creditHours) hours", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
            largeNameLabel.attributedText = title
            nameTextField.text = clas.title
            iconImageView.setImage(clas.icon, for: .normal)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    fileprivate func setupUI() {
        view.addSubview(iconLabel)
        view.addSubview(iconImageView)
        view.addSubview(largeNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(seasonLabel)
        view.addSubview(yearLabel)
        view.addSubview(pickerView)
        
        iconLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: iconImageView.rightAnchor, paddingTop: 30, paddingLeft: 58, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        iconImageView.anchor(top: iconLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        largeNameLabel.anchor(top: iconImageView.topAnchor, left: iconImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        nameLabel.anchor(top: iconImageView.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameTextField.anchor(top: nameLabel.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: largeNameLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        seasonLabel.anchor(top: nameTextField.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        yearLabel.anchor(top: nameTextField.bottomAnchor, left: view.centerXAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        pickerView.anchor(top: yearLabel.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
}
