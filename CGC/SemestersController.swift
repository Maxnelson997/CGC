//
//  ViewController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

struct Semester {
    let icon:UIImage
    let title:String
    let GPALabel:String
    let creditHours:String
}

class SemestersController: UITableViewController {
    
    var semesters = [Semester]()
    var cellId:String = "cellId"
    
    
    let userInfoLabel:TabbedLabel = {
        let label = TabbedLabel()
        let title = NSMutableAttributedString(string: "Jane Smith", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18) ?? UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.black])
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
            Semester(icon: UIImage(), title: "Fall 2017", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "Fall 2017", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "Fall 2017", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "Fall 2017", GPALabel: "3.45 GPA", creditHours: "15 credit hours")
        ]
        
        view.backgroundColor = .clear
        navigationItem.title = "Semesters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        
        tableView.register(SemesterCell.self, forCellReuseIdentifier: cellId)
        tableView.isSpringLoaded = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    var isEditingSemesters:Bool = false
    
    //actions
    @objc func handleEdit() {
        print("trying to edit")
        isEditingSemesters = !isEditingSemesters
        tableView.reloadData()
    }
    
    @objc func handleAdd() {
        let ASC = AddSemesterController()
        let ASC_NAV = CustomNavController(rootViewController: ASC)
        present(ASC_NAV, animated: true, completion: nil)
    }
    
    //tableview
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.addArrangedSubview(userInfoLabel)
        view.addArrangedSubview(GPALabel)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return semesters.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //change later to include disabled cells section.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SemesterCell
        cell.tag = indexPath.item
        cell.semester = semesters[indexPath.item]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.isEditingCell = isEditingSemesters
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableView.beginUpdates()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tableView.endUpdates()
    }
    
}

