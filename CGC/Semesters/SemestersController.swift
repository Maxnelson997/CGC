//
//  ViewController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

struct SemesterClass {
    let icon:UIImage
    let title:String
    let grade:String
    let creditHours:Int
    var gpa:String = "0.0"
    
    
    init(icon:UIImage, title:String, grade:String, creditHours:Int) {
        self.icon = icon
        self.title = title
        self.grade = grade
        self.creditHours = creditHours
        self.gpa = String(describing: getGPA(for: grade, hour: Double(creditHours)))
    }
}

func getGPA(for grade: String, hour: Double) -> Double {
    let gpa:Double = letters[grade]!
    //    let points = grade_value * hour
    //    let gpa = points/hour
    //    return gpa
    return gpa
}


let letters:[String:Double] = [
    "A+":4.0,
    "A":4.0,
    "A-":3.7,
    "B+":3.33,
    "B":3.00,
    "B-":2.7,
    "C+":2.3,
    "C":2.0,
    "C-":1.7,
    "D+":1.3,
    "D":1.0,
    "D-":0.70,
    "F":0]

struct Semester {
    let icon:UIImage
    let title:String
    var GPALabel:String
    var classes:[SemesterClass] = []
    var selected:Bool = false
    
    init(icon:UIImage, title:String, GPALabel:String, classes:[SemesterClass]) {
        self.icon = icon
        self.title = title
        self.GPALabel = GPALabel
        self.classes = classes
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
    
    fileprivate func calculateAllInfo() {
        let totalSemesters = semesters.count
        var totalClasses = 0.0
        var totalCreditHours = 0.0
        var totalPointsEarned = 0.0
        var totalGPA = 0.0
        
        for i in 0 ..< semesters.count {

            var semesterCreditHours:Double = 0
            var semesterPointsEarned:Double = 0.0
            var semesterGPA:Double = 0.0

            for k in 0 ..< semesters[i].classes.count {
                semesterCreditHours += Double(semesters[i].classes[k].creditHours)
                semesterPointsEarned += Double(semesters[i].classes[k].creditHours) * getGPA(for: semesters[i].classes[k].grade, hour: Double(semesters[i].classes[k].creditHours))
                semesters[i].classes[k].gpa = String(describing: getGPA(for: semesters[i].classes[k].grade, hour: Double(semesters[i].classes[k].creditHours)))
            }
//            (4*(3.7) + 3*(3.0))/7.0
            totalCreditHours += semesterCreditHours
            totalPointsEarned += semesterPointsEarned
            totalClasses += Double(semesters[i].classes.count)

            semesterGPA = semesterPointsEarned / semesterCreditHours
            semesters[i].GPALabel = String(format: "%.2f", semesterGPA)
        }
        
        totalGPA = totalPointsEarned / totalCreditHours
        let totalGPAString = String(format: "%.2f", totalGPA)
        
        tableView.reloadData()
        
        let title = NSMutableAttributedString(string: "Your Stats", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 18) ?? UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.black])
        let info = NSMutableAttributedString(string: "\nSemesters: \(totalSemesters)\nClasses: \(totalClasses)\nCredit Hours: \(totalCreditHours)", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        title.append(info)
        userInfoLabel.attributedText = title
        
        let GPAtitle = NSMutableAttributedString(string: totalGPAString, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 40) ?? UIFont.systemFont(ofSize: 40), NSAttributedStringKey.foregroundColor: UIColor.black])
        let GPAinfo = NSMutableAttributedString(string: "\nout of 4.0", attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura", size: 12) ?? UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor: UIColor(white: 0.5, alpha: 1)])
        GPAtitle.append(GPAinfo)
        GPALabel.attributedText = GPAtitle
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        semesters = [
            Semester(icon: #imageLiteral(resourceName: "alien-1"), title: "ONE", GPALabel: "3.45 GPA", classes: [SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class title", grade: "A-", creditHours: 3)]),
            Semester(icon: #imageLiteral(resourceName: "astronaut"), title: "TWO", GPALabel: "3.45 GPA", classes: [SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class title", grade: "A-", creditHours: 6),SemesterClass(icon: #imageLiteral(resourceName: "robot"), title: "class title", grade: "A", creditHours: 3)]),
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
        
        DispatchQueue.main.async {
            self.semesters.append(semester)
            let newIndexPath = IndexPath(row: self.semesters.count - 1, section: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [newIndexPath], with: .right)
            self.tableView.endUpdates()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.calculateAllInfo()
        }
        

        
        
        
        
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
//        DispatchQueue.main.async {
            guard self.indexes.count > 0 else { return }
            //filter out selected semesters. obliterate them.
            self.semesters = self.semesters.filter { !$0.selected }
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: self.indexes, with: .right)
            self.tableView.endUpdates()
            self.handleEdit()
//        }
        calculateAllInfo()

    }
    
    @objc func handleDisable() {
        print("trying to disable")
        
    }
    
    

}

