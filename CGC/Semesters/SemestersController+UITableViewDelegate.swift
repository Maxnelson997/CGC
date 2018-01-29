//
//  SemestersController+UITableViewDelegate.swift
//  CGC
//
//  Created by Max Nelson on 1/28/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

extension SemestersController {
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
            let classesController = ClassesController()
            classesController.semester = semesters[indexPath.row]
            navigationController?.pushViewController(classesController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if !isEditingSemesters { footerView.alpha = 0 }
        return footerView
    }
}
