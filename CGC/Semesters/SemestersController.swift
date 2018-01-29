//
//  ViewController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class SemestersController: UITableViewController {
    
    var indexes = [IndexPath]()
    var semesters = [Semester]()
    var cellId:String = "cellId"
    var isEditingSemesters:Bool = false
    
    lazy var footerView:UIView = {
        let footerView = UIStackView()
        let bg = UIView()
        bg.backgroundColor = UIColor.appleBlue.withAlphaComponent(0.2)
        footerView.addSubview(bg)
        bg.anchorEntireView(to: footerView)
        footerView.axis = .horizontal
        footerView.distribution = .fillEqually
        footerView.addArrangedSubview(deleteButton)
        footerView.addArrangedSubview(UIView())
        footerView.addArrangedSubview(disableButton)
        footerView.alpha = 0
        return footerView
    }()
    
    lazy var disableButton:UIButton = {
        let b = UIButton()
        b.backgroundColor = .clear
        b.setTitle("disable", for: .normal)
        b.setTitleColor(.appleBlue, for: .normal)
        b.titleLabel?.font = UIFont.init(name: "Futura-Bold", size: 18)
        b.addTarget(self, action: #selector(handleDisable), for: .touchUpInside)
        return b
    }()
    
    lazy var deleteButton:UIButton = {
        let b = UIButton()
        b.backgroundColor = .clear
        b.setTitle("delete", for: .normal)
        b.setTitleColor(.appleBlue, for: .normal)
        b.titleLabel?.font = UIFont.init(name: "Futura-Bold", size: 18)
        b.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        return b
    }()
    
    let userInfoLabel:TabbedLabel = {
        let label = TabbedLabel()
        let title = NSMutableAttributedString(string: "Your Stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18) ?? UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.black])
        let info = NSMutableAttributedString(string: "\nSemesters: 5\nClasses: 21\nCredit Hours: 68", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        label.attributedText = title
        label.numberOfLines = 0
        return label
    }()
    
    let GPALabel:TabbedRightLabel = {
        let label = TabbedRightLabel()
        let title = NSMutableAttributedString(string: "3.45", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 40) ?? UIFont.systemFont(ofSize: 40), NSAttributedStringKey.foregroundColor: UIColor.black])
        let info = NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        label.attributedText = title
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        semesters = [
            Semester(icon: #imageLiteral(resourceName: "alien-1"), title: "ONE", classes: [SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class boi", grade: "A-", creditHours: 3)]),
            Semester(icon: #imageLiteral(resourceName: "alien-1"), title: "ONE", classes: []),
            Semester(icon: #imageLiteral(resourceName: "astronaut"), title: "TWO", classes: [SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class swag", grade: "A-", creditHours: 6),SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class title", grade: "A", creditHours: 3)]),
        ]
        
        calculateAllInfo()
        
        view.backgroundColor = .clear
        navigationItem.title = "Semesters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        
        tableView.register(SemesterCell.self, forCellReuseIdentifier: cellId)
        tableView.isSpringLoaded = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 100))
        tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0)
    }


}




