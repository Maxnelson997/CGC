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
    
    var text:String? {
        didSet {
            guard let text = text else { return }
            header.text = text
        }
    }
    
    private let header = TitleLabel(text: "string", size: 30, alignment: .left, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(header)
        header.anchorEntireView(to: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


struct IconSet {
    let title:String
    let icons:[UIImage]
}

class SelectIconController:UICollectionViewController {
    var iconSets = [IconSet]()
    var icons = [UIImage]()
    
    var delegate:SelectIconDelegate?
    
    var cellId = "cellId"
    var headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconSetOne = IconSet(title: "Space", icons:[#imageLiteral(resourceName: "astronaut"),#imageLiteral(resourceName: "telescope"),#imageLiteral(resourceName: "robot"),#imageLiteral(resourceName: "ufo"),#imageLiteral(resourceName: "alien-1"),#imageLiteral(resourceName: "saturn"),#imageLiteral(resourceName: "shooting-star"),#imageLiteral(resourceName: "alien"),#imageLiteral(resourceName: "lander"),#imageLiteral(resourceName: "space-shuttle-1"),#imageLiteral(resourceName: "galaxy"),#imageLiteral(resourceName: "space-suit"),#imageLiteral(resourceName: "meteorites"),#imageLiteral(resourceName: "hubble-space-telescope"),#imageLiteral(resourceName: "rocket-ship-2"),#imageLiteral(resourceName: "nasa")])
        let iconSetTwo = IconSet(title: "Occupation", icons:[#imageLiteral(resourceName: "welder"),#imageLiteral(resourceName: "gentleman"),#imageLiteral(resourceName: "builder-1"),#imageLiteral(resourceName: "swat"),#imageLiteral(resourceName: "soldier"),#imageLiteral(resourceName: "showman"),#imageLiteral(resourceName: "diver"),#imageLiteral(resourceName: "scientist"),#imageLiteral(resourceName: "boy-4"),#imageLiteral(resourceName: "dj"),#imageLiteral(resourceName: "croupier"),#imageLiteral(resourceName: "soldier-1"),#imageLiteral(resourceName: "captain")])
        let iconSetThree = IconSet(title: "Tech", icons:[#imageLiteral(resourceName: "memory-card"),#imageLiteral(resourceName: "pendrive"),#imageLiteral(resourceName: "plug"),#imageLiteral(resourceName: "plug-1"),#imageLiteral(resourceName: "mouse"),#imageLiteral(resourceName: "joystick"),#imageLiteral(resourceName: "projector"),#imageLiteral(resourceName: "keyboard")])
        let iconSetFour = IconSet(title: "The Almighty Dollar", icons:[#imageLiteral(resourceName: "planet-earth"),#imageLiteral(resourceName: "wallet-1"),#imageLiteral(resourceName: "money-1"),#imageLiteral(resourceName: "hand-shake"),#imageLiteral(resourceName: "calendar-2"),#imageLiteral(resourceName: "dollar"),#imageLiteral(resourceName: "wallet"),#imageLiteral(resourceName: "money")])

        iconSets = [
            iconSetOne, iconSetTwo, iconSetThree, iconSetFour
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
            header.text = iconSets[indexPath.section].title
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
