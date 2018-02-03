//
//  UpgradeController.swift
//  CGC
//
//  Created by Max Nelson on 2/2/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class ReasonCell:UICollectionViewCell {
    var reason:String? {
        didSet {
            guard let reason = reason else { return }
            label.text = reason
        }
    }
    
    var label:UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "Futura-Bold", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchorEntireView(to: self, withInsets: UIEdgeInsetsMake(0, 4, 0, 0))
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UpgradeController:UICollectionViewController {
    
    var reasons = [String]()
    
    var cellId = "cellId"
    var headerId = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Upgrade"
        setupCancelButton()
        
        reasons = [
            "Unlimited Semesters",
            "Unlimited Classes",
            "Unlimited Icons",
            "Tuition costs you thousands of dollars",
            "A dollar here will help make sure those thousands are well spent",
            "And yeah, the Icons are pretty dope",
            "I already purchased this!",
            "Yeah I want it all!"
        ]
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ReasonCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(IconHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.backgroundColor = UIColor(rgb: 0xF3F3F3)
    }
}

extension UpgradeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == reasons.count - 1 || indexPath.item == reasons.count - 2 {
            return CGSize(width: view.frame.width/2 - 21, height: 50)
        }
        return CGSize(width: view.frame.width - 32, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReasonCell

        cell.reason = reasons[indexPath.item]
        if indexPath.item == reasons.count - 2 {
            //restore
            cell.backgroundColor = UIColor.orangeTheme
            cell.label.textColor = UIColor.white
        } else if indexPath.item == reasons.count - 1 {
            //purchase
            purchase()
            cell.backgroundColor = UIColor.appleBlue
            cell.label.textColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! IconHeader
            let attributedText = NSMutableAttributedString(string: "Dope Edition\n", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedText.append(NSAttributedString(string: "Tuition is thousands of dollars. If using the paid version of this app helps you manage and pass just one class you will have saved hundereds if not thousands of dollars. All for a dollar. Investment.", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura", size: 12)!]))
            header.attributedText = attributedText
            return header
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == reasons.count - 2 {
            //restore
            restore()
        } else if indexPath.item == reasons.count - 1 {
            //purchase
            purchase()
        }
    }
    
    func restore() {
        print("trying to restore")
    }
    
    func purchase() {
        print("trying to purchase")
    }
    



    
}
