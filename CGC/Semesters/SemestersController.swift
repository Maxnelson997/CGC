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
    var isEditingSemesterInfo:Bool = false
    var c = DefaultValues.shared.themeColor
    
    lazy var footerView:UIView = {
        let footerView = UIStackView()
        let bg = UIView()
        bg.backgroundColor = c.withAlphaComponent(0.2)
        footerView.addSubview(bg)
        bg.anchorEntireView(to: footerView)
        footerView.axis = .horizontal
        footerView.distribution = .fillEqually
        footerView.addArrangedSubview(deleteButton)
        footerView.addArrangedSubview(UIView())
        footerView.addArrangedSubview(UIView())
//        footerView.addArrangedSubview(disableButton)
        footerView.alpha = 0
        return footerView
    }()
    
//    lazy var disableButton:UIButton = {
//        let b = UIButton()
//        b.backgroundColor = .clear
//        b.setTitle("disable", for: .normal)
//        b.setTitleColor(.appleBlue, for: .normal)
//        b.titleLabel?.font = UIFont.init(name: "Futura-Bold", size: 18)
//        b.addTarget(self, action: #selector(handleDisable), for: .touchUpInside)
//        return b
//    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        c = DefaultValues.shared.themeColor
        footerView.subviews.first?.backgroundColor = c.withAlphaComponent(0.2)
        if !isEditingSemesterInfo {
            calculateAllInfo() // semester classes were potentially modified
            tableView.reloadData()
            DefaultValues.shared.themeWasChanged = false
        } else {
            isEditingSemesterInfo = false
        }

    }

    func checkPurchases() {
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_PURCHASE_DOPE_EDITION) {
            DefaultValues.shared.isUserFreemium = false
        } else {
            DefaultValues.shared.isUserFreemium = false //TESTTHIS
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPurchases()
        
        let hasntLaunched = DefaultValues.CheckLaunch()
        if hasntLaunched {
            //choose an icon
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
            let FLC = FirstLaunchController(collectionViewLayout: layout)
            FLC.navigationItem.title = "Getting Started"
            let FLC_NAV = CustomNavController(rootViewController: FLC)
            present(FLC_NAV, animated: true, completion: nil)
        }
        semesters = CoreDataManager.shared.fetchSemesters()
//        calculateAllInfo()
        
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




