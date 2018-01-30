//
//  ClassesController.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class ClassesController: UITableViewController {
    
    var indexes = [IndexPath]()
    var classes = [SemesterClass]()
    var cellId:String = "cellId"
    var isEditingClasses:Bool = false
    
    var semester:Semester?
    var index:Int?
    var delegate:UpdateSemesterDelegate?
    
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
    
    lazy var userInfoLabel:TabbedLabel = {
        let label = TabbedLabel()
        let title = NSMutableAttributedString(string: "\(semester?.title ?? "Semester") stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nClasses: 21\nCredit Hours: 68", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)! ,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        label.attributedText = title
        label.numberOfLines = 0
        return label
    }()
    
    let GPALabel:TabbedRightLabel = {
        let label = TabbedRightLabel()
        let title = NSMutableAttributedString(string: "3.45", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 40)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        title.append(NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12)!,NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)]))
        label.attributedText = title
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        guard let semester = semester else { return }
        
        guard let semesterClasses = semester.semesterClasses?.allObjects as? [SemesterClass] else { return }
        classes = semesterClasses
        
        calculateAllInfo()
        
        view.backgroundColor = .clear
        navigationItem.title = "Classes"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd)), UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))]
        
        tableView.register(ClassCell.self, forCellReuseIdentifier: cellId)
        tableView.isSpringLoaded = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 100))
        tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0)
    }
    
    
}




