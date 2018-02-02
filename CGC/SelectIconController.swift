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

class IconHeader:UICollectionReusableView {
    
    var attributedText:NSAttributedString? {
        didSet {
            guard let attributedText = attributedText else { return }
            header.attributedText = attributedText
        }
    }
    
    private let header = InsetLabel(text: "string", size: 30, alignment: .left, font: .regular, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(header)
        header.anchorEntireView(to: self, withInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


struct IconSet {
    let title:String
    let icons:[UIImage]
    let count:Int
}

class SelectIconController:UICollectionViewController {
    var iconSets = [IconSet]()
    var icons = [UIImage]()
    
    var delegate:SelectIconDelegate?
    
    var cellId = "cellId"
    var headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let i = DefaultValues.shared
 
        iconSets = [
            IconSet(title: "Animals", icons: i.ANIMALS_PACK, count: i.ANIMALS_PACK.count),
            IconSet(title: "Occupation", icons:[#imageLiteral(resourceName: "welder"),#imageLiteral(resourceName: "gentleman"),#imageLiteral(resourceName: "builder-1"),#imageLiteral(resourceName: "swat"),#imageLiteral(resourceName: "soldier"),#imageLiteral(resourceName: "showman"),#imageLiteral(resourceName: "diver"),#imageLiteral(resourceName: "scientist"),#imageLiteral(resourceName: "boy-4"),#imageLiteral(resourceName: "dj"),#imageLiteral(resourceName: "croupier"),#imageLiteral(resourceName: "soldier-1"),#imageLiteral(resourceName: "captain")], count: 10),
            IconSet(title: "Audiooooo", icons: i.AUDIO_PACK, count: i.AUDIO_PACK.count)
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


extension SelectIconController: UICollectionViewDelegateFlowLayout {
    
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
        cell.icon.setImage(iconSets[indexPath.section].icons[indexPath.item], for: .normal)
        
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
             self.delegate?.chooseIcon(image: self.iconSets[indexPath.section].icons[indexPath.item])
        }
    }
}
