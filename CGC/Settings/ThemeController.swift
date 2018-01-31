//
//  ThemeController.swift
//  CGC
//
//  Created by Max Nelson on 1/30/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

struct Theme {
    var title:String
    var color:UIColor
}

class ThemeCell:UICollectionViewCell {
    
    var theme:Theme? {
        didSet {
            guard let theme = theme else { return }
            icon.backgroundColor = theme.color
            themeTitle.attributedText = NSMutableAttributedString(string: theme.title, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        }
    }
    
    let themeTitle:TitleLabel = {
       return TitleLabel()
    }()
    
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
        
        addSubview(themeTitle)
        addSubview(icon)
        themeTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 40)
        icon.anchor(top: themeTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ThemeController:UICollectionViewController {
    
    var themes = [Theme]()
    
    var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        let c = DefaultValues.shared.colors
        themes.append(Theme(title: "Bitchin Blue", color: c[0]))
        themes.append(Theme(title: "Gottem Green", color: c[1]))
        themes.append(Theme(title: "Godly Golden", color: c[2]))
        themes.append(Theme(title: "Boring Billy", color: c[3]))
        themes.append(Theme(title: "Optimal Orange", color: c[4]))
        themes.append(Theme(title: "Teal Tacos", color: c[5]))
        themes.append(Theme(title: "Radical Red", color: c[6]))
        themes.append(Theme(title: "Got Green", color: c[7]))
        themes.append(Theme(title: "But Blue", color: c[8]))
        themes.append(Theme(title: "Poppin Purple", color: c[9]))
        
        navigationItem.title = "Pick a Theme"
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ThemeCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.backgroundColor = .white
    }
    
}

extension ThemeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/3)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ThemeCell
        cell.theme = themes[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setTheme(theme: themes[indexPath.item])
        dismiss(animated: true, completion: nil)
    }
    
    
}

