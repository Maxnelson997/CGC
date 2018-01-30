//
//  ClassesController+UITableViewDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//



import UIKit

extension ClassesController {
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
        return classes.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //change later to include disabled cells section.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ClassCell
        cell.tag = indexPath.item + 1
        cell.clas = classes[indexPath.item]
        cell.delegate = self
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.isEditingCell = isEditingClasses
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditingClasses {
            let cell = tableView.cellForRow(at: indexPath) as! ClassCell
            cell.handleEdit()
        } else {
            //open class
            openClass(at: indexPath.item)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.classes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .bottom)
            self.footerView.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
//                self.semester?.classes = self.classes
                guard let semester = self.semester else { return }
                guard let index = self.index else { return }
                self.delegate?.saveSemester(semester: semester, at: index)
                self.footerView.alpha = 0
            })
        }
        deleteAction.backgroundColor = .lightRed
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, indexPath) in
            self.openClass(at: indexPath.item)
        }
        editAction.backgroundColor = UIColor.black.withAlphaComponent(0.8)//.aplGreen
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //        if !isEditingSemesters { footerView.alpha = 0 }
        return footerView
    }
    
    //open class used within didSelectRowAt and editActionsForRowAt
    func openClass(at index:Int) {
        let ACC = AddClassController()
        ACC.delegate = self
        ACC.semester = semester
        ACC.classToEdit = classes[index]
        ACC.isEdit = true
        let ACC_NAV = CustomNavController(rootViewController: ACC)
        present(ACC_NAV, animated: true, completion: nil)
    }
}
