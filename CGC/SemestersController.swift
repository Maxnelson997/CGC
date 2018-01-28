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
    var selected:Bool = false
    
    init(
    icon:UIImage,
    title:String,
    GPALabel:String,
    creditHours:String
    ) {
        self.icon = icon; self.title = title; self.GPALabel = GPALabel; self.creditHours = creditHours
    }
}

protocol IndexDelegate {
    func setSemesterSelected(at index:Int)
}

protocol AddSemesterDelegate {
    func addSemester(semester: Semester)
}

class SemestersController: UITableViewController, IndexDelegate, AddSemesterDelegate {
    
    func setSemesterSelected(at index:Int) {
        print("selected index:",index)
        if index <= semesters.count {
            semesters[index].selected = !semesters[index].selected
            if semesters[index].selected {
                indexes.append(IndexPath(row: index, section: 0))
            } else {
                indexes = indexes.filter { $0.row != index }
            }
        } else {
            assert(false, "out of range")
        }
    }
    
    var indexes = [IndexPath]()
    var semesters = [Semester]()
    var cellId:String = "cellId"
    
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
            Semester(icon: UIImage(), title: "ONE", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "TWO", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "THREE", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "FOUR", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "FIVE", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "SIX", GPALabel: "3.45 GPA", creditHours: "15 credit hours"),
            Semester(icon: UIImage(), title: "SEVEN", GPALabel: "3.45 GPA", creditHours: "15 credit hours")
        ]
        
        view.backgroundColor = .clear
        navigationItem.title = "Semesters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        
        tableView.register(SemesterCell.self, forCellReuseIdentifier: cellId)
        tableView.isSpringLoaded = true
        tableView.delegate = self
        tableView.dataSource = self
        
        let dummyViewHeight = CGFloat(100)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
    }
    

    var isEditingSemesters:Bool = false

    //actions
    @objc func handleEdit() {
        if isEditingSemesters {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.handleEdit))
             navigationItem.rightBarButtonItem = .none
        }
        indexes = []
        for var sem in semesters {
            sem.selected = false
        }
        isEditingSemesters = !isEditingSemesters
        let alpha:CGFloat = isEditingSemesters ? 1 : 0
        UIView.animate(withDuration: 0.3) {
            self.footerView.alpha = alpha
        }
        tableView.reloadData()
    }
    
    @objc func handleAdd() {
        let ASC = AddSemesterController()
        ASC.delegate = self
        let ASC_NAV = CustomNavController(rootViewController: ASC)
        present(ASC_NAV, animated: true, completion: nil)
    }
    
    
    func addSemester(semester: Semester) {
        semesters.append(semester)
        let newIndexPath = IndexPath(row: semesters.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .right)
        tableView.endUpdates()
    }
    
    //tableview
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.addArrangedSubview(userInfoLabel)
        view.addArrangedSubview(GPALabel)
//        let bg = UIView()
//        bg.addSubview(view)
//        bg.backgroundColor = .lightBlue
//        view.anchorEntireView(to: bg)
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
        cell.tag = indexPath.item + 1
        cell.semester = semesters[indexPath.item]
        cell.delegate = self
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.isEditingCell = isEditingSemesters
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditingSemesters {
            let cell = tableView.cellForRow(at: indexPath) as! SemesterCell
            cell.handleEdit()
        } else {
            //open semester
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func handleOpen() {
        
    }
    
    @objc func handleDelete() {
        guard indexes.count > 0 else { return }
        //filter out selected semesters. obliterate them.
        semesters = semesters.filter { !$0.selected }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .right)
        tableView.endUpdates()
//        indexes = []
//        for var sem in semesters {
//            sem.selected = false
//        }
//        tableView.reloadData()
        handleEdit()
    }
    
    @objc func handleDisable() {
        print("trying to disable")
        
    }
    
    

}

