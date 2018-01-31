//
//  IconsController.swift
//  CGC
//
//  Created by Max Nelson on 1/27/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class IconCell:UICollectionViewCell {
    
    let icon:UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        icon.anchorEntireView(to: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SelectIconController:UICollectionViewController {
    
    var icons = [UIImage]()
    
    var delegate:SelectIconDelegate?
    
    var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icons = [
            #imageLiteral(resourceName: "astronaut"),#imageLiteral(resourceName: "telescope"),#imageLiteral(resourceName: "robot"),#imageLiteral(resourceName: "ufo"),#imageLiteral(resourceName: "alien-1"),#imageLiteral(resourceName: "saturn"),#imageLiteral(resourceName: "shooting-star"),#imageLiteral(resourceName: "alien")
        ]
        
        navigationItem.title = "Pick an icon"
        setupCancelButton()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(IconCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView?.backgroundColor = .white
    }
    
}

extension SelectIconController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconCell
        cell.icon.setImage(icons[indexPath.item], for: .normal)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true) {
             self.delegate?.chooseIcon(image: self.icons[indexPath.item])
        }
    }

    
}
