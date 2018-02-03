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
    var titleColor:UIColor
}

class ThemeHeader:UICollectionReusableView {
    
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


class ThemeCell:UICollectionViewCell {
    
    var theme:Theme? {
        didSet {
            guard let theme = theme else { return }
            icon.backgroundColor = theme.color
            themeTitle.text = theme.title
            themeTitle.textColor = theme.titleColor
        }
    }
    
    let themeTitle:UITextView = {
        let tv =  UITextView()
        tv.backgroundColor = .clear
        tv.isUserInteractionEnabled = false
        tv.isEditable = false
        tv.font = UIFont.init(name: "Futura-Bold", size: 12)
        return tv
    }()
    
    let icon:UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(icon)
        addSubview(themeTitle)
//        themeTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
        themeTitle.anchorEntireView(to: self, withInsets: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct ThemeSet {
    let title:String
    let themes:[Theme]
}

class ThemeController:UICollectionViewController {
    
    var themes = [Theme]()
    var themeSets = [ThemeSet]()
    
    var cellId = "cellId"
    var headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        let c = DefaultValues.shared.colors
        
        let themeSetOne = ThemeSet(
            title: "Free AF",
            themes: [
                Theme(title: "Git Commit Green", color: c[10], titleColor: .black),
                Theme(title: "Bitchin Blue", color: c[8], titleColor: .white),
                Theme(title: "Boring Billy", color: c[3], titleColor: .appleBlue),
            ]
        )
        let themeSetTwo = ThemeSet(
            title: "Bright AF",
            themes: [
                Theme(title: "Godly Golden", color: c[2], titleColor: .black),
                Theme(title: "Optimal Orange", color: c[4], titleColor: .white),
                Theme(title: "Teal Tacos", color: c[5], titleColor: .white),
            ]
        )
        let themeSetThree = ThemeSet(
            title: "Litty as a kitty",
            themes: [
                Theme(title: "Blue, Boi!", color: c[0], titleColor: .white),
                Theme(title: "Got Green", color: c[1], titleColor: .black),
                Theme(title: "Radical Red", color: c[6], titleColor: .white),
                Theme(title: "Poppin Purple", color: c[9], titleColor: .white),
                Theme(title: "Gottem! Green", color: c[7], titleColor: .black),
            ]
        )
        let themeSetFour = ThemeSet(
            title: "bruh",
            themes: [
                Theme(title: "Garbage Golden", color: c[11], titleColor: .white),
                Theme(title: "Garbage Golden Reversed", color: c[11], titleColor: .black),
            ]
        )
        
        themeSets.append(themeSetOne)
        themeSets.append(themeSetTwo)
        themeSets.append(themeSetThree)
        themeSets.append(themeSetFour)
        
        navigationItem.title = "Pick a Theme"
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ThemeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ThemeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.backgroundColor = .white
    }
    
}

extension ThemeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeSets[section].themes.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return themeSets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // sectionInset reference comment: layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        // on width: -16 for left and right inset, -16 for space between cells equal to left & right insets
        // on height: + 40 for label height. this keeps the color a square
        let width = collectionView.frame.width/3.5 - 32
        let height = width + 0
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ThemeCell
        cell.theme = themeSets[indexPath.section].themes[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.popAnimation {
            if indexPath.section != 0 && DefaultValues.shared.isUserFreemium {
                let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
                let UPC = UpgradeController(collectionViewLayout: layout)
                let UPC_NAV = CustomNavController(rootViewController: UPC)
                self.navigationController?.present(UPC_NAV, animated: true, completion: nil)
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setTheme(theme: self.themeSets[indexPath.section].themes[indexPath.item])
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ThemeHeader
            header.text = themeSets[indexPath.section].title
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    
}

