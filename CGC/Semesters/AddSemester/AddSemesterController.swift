//
//  addSemesterController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

protocol SelectIconDelegate {
    func chooseIcon(image:UIImage)
}

class AddSemesterController: UIViewController, SelectIconDelegate {
    
    //pickerview data
    var season = "Spring"
    var year = "2018"
    
    var seasons:[String] = ["Spring", "Sum", "Fall", "Winter"]
    
    var years:[String] = {
        var s = [String]()
        for i in 1 ..< 41 {
            if i != 2018 {
                if i < 10 {
                    s.append("0" + String(describing: i))
                } else {
                    s.append(String(describing: i))
                }
            }
        }
        return s
    }()
    
    var delegate:AddSemesterDelegate?

    //components
    let iconLabel = TitleLabel(text: "Icon", size: 18, alignment: .left)
    
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
    
    let largeNameLabel:TabbedRightLabel = {
        let label = TabbedRightLabel()
        let title = NSMutableAttributedString(string: "Fall", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 42) ?? UIFont.systemFont(ofSize: 42), NSAttributedStringKey.foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        let info = NSMutableAttributedString(string: "\n2019", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        label.attributedText = title
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let nameLabel = TitleLabel(text: "Name", size: 18, alignment: .left)
    
    let nameTextField:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blackPointEight
        tf.textColor = .white
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.font = UIFont.init(name: "Futura", size: 16)
        tf.paddingLeft = 8
        tf.attributedPlaceholder = NSAttributedString(string: "Type here or pick a season & year", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 14)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.6, alpha: 1)])
        return tf
    }()
    
    let seasonLabel = TitleLabel(text: "Season", size: 18, alignment: .left)
    
    let yearLabel = TitleLabel(text: "Year", size: 18, alignment: .center)
    
    let pickerView:UIPickerView = {
        let p = UIPickerView()
        p.backgroundColor = .blackPointEight
        p.layer.cornerRadius = 8
        p.layer.masksToBounds = true
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Semester"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        setupCancelButton()
        setupUI()
        pickerView.dataSource = self
        pickerView.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTextField)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    fileprivate func setupUI() {
        view.addSubview(iconLabel)
        view.addSubview(iconImageView)
        view.addSubview(largeNameLabel)
        //
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        //
        view.addSubview(seasonLabel)
        view.addSubview(yearLabel)
        view.addSubview(pickerView)
        
        iconLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: iconImageView.rightAnchor, paddingTop: 30, paddingLeft: 58, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        iconImageView.anchor(top: iconLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        largeNameLabel.anchor(top: iconImageView.topAnchor, left: iconImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        //
        nameLabel.anchor(top: iconImageView.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameTextField.anchor(top: nameLabel.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: largeNameLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        //
        seasonLabel.anchor(top: nameTextField.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        yearLabel.anchor(top: nameTextField.bottomAnchor, left: view.centerXAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        pickerView.anchor(top: yearLabel.bottomAnchor, left: iconImageView.leftAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
    @objc fileprivate func handleSave() {
        var semesterImage = UIImage()
        if let iconImage = iconImageView.imageView?.image {
            semesterImage = iconImage
        }
        let newSemester = Semester(icon: semesterImage, title: "\(season) \(year)", GPALabel: "4.0?", classes: [SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "Robotics", grade: "A-", creditHours: 4)])
        dismiss(animated: true) {
            self.delegate?.addSemester(semester: newSemester)
        }

    }
    
    @objc func handleAddIcon() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        let SIC = SelectIconController(collectionViewLayout: layout)
        SIC.delegate = self
        let SIC_NAV = CustomNavController(rootViewController: SIC)
        present(SIC_NAV, animated: true, completion: nil)
    }
    
    func chooseIcon(image: UIImage) {
        iconImageView.setImage(image, for: .normal)
    }
    
    @objc func dismissTextField() {
        nameTextField.resignFirstResponder()
    }

    
}
