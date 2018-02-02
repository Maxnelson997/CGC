//
//  FirstLaunchController.swift
//  CGC
//
//  Created by Max Nelson on 2/2/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class FirstLaunchController:UICollectionViewController {
    var iconSets = [IconSet]()
    var icons = [UIImage]()
    
    var cellId = "cellId"
    var headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconSets = [
            // avatars
            IconSet(title: "Options", icons: DefaultValues.shared.ICON_OPTIONS),
        ]
        
        navigationItem.title = "Pick an icon"
        setupCancelButton()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(IconCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(IconHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.backgroundColor = .white
    }
}

extension FirstLaunchController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return iconSets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconSets[section].icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if iconSets[indexPath.section].icons.count > 8 {
            return CGSize(width: 60, height: 60)
        }
        return CGSize(width: 75, height: 75)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconCell
        cell.icon.backgroundColor = .clear
        cell.icon.setImage(iconSets[indexPath.section].icons[indexPath.item], for: .normal)
        if iconSets[indexPath.section].title == "Emoji" {
            cell.icon.tintColor = .white
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! IconHeader
            let attributedText = NSMutableAttributedString(string: iconSets[indexPath.section].title, attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura-Bold", size: 30)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedText.append(NSAttributedString(string: "\n\(String(describing: iconSets[indexPath.section].count)) icons", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura", size: 15)!]))
            header.attributedText = attributedText
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true) {
//            self.delegate?.chooseIcon(image: self.iconSets[indexPath.section].icons[indexPath.item])
        }
    }
}
