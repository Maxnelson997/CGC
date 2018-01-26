//
//  ViewController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class SemestersController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightBlue
        navigationItem.title = "Semesters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.handleAdd))
        setupUI()
    }
    
    private func setupUI() {
        let backgroundGradient = AAGradient(frame: UIScreen.main.bounds, colors: [.lightBlue, .white], locations: [0.1, 1])
        view.addSubview(backgroundGradient)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleEdit() {
        print("trying to edit")
    }
    
    @objc func handleAdd() {
        print("trying to add")
    }
    
    
}

