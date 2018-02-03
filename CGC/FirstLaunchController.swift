//
//  FirstLaunchController.swift
//  CGC
//
//  Created by Max Nelson on 2/2/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import Firebase

class FirstLaunchController:UICollectionViewController {
    

    var iconSets = [IconSet]()
    
    var cellId = "cellId"
    var headerId = "headerId"
    
    var iconNames:[String] = ["option0","option1","option2","option3","option4","option5","option6","option7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconSets = [
            // avatars
            IconSet(title: "This app is meant to be customizable. So choose the app icon you prefer. You'll only be asked this once but can change it anytime in the settings tab.", icons: DefaultValues.shared.ICON_OPTIONS),
        ]

        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(IconCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(IconHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.backgroundColor = UIColor(rgb: 0xF3F3F3)
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
        return CGSize(width: 100, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconCell
        cell.icon.backgroundColor = .clear
        cell.icon.setImage(iconSets[indexPath.section].icons[indexPath.item], for: .normal)
        cell.icon.layer.cornerRadius = 25
        cell.icon.imageEdgeInsets = .zero
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! IconHeader
            let attributedText = NSMutableAttributedString(string: "Customize your app icon\n", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedText.append(NSAttributedString(string: iconSets[indexPath.section].title, attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura", size: 12)!]))
            header.attributedText = attributedText
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DefaultValues.setAppIcon(name: "option\(String(describing: indexPath.item))")
        sendIconSelectionResponse(iconOption: "option\(String(describing: indexPath.item))")
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func sendIconSelectionResponse(iconOption: String) {
        let ref = Database.database().reference()
        var values = [String:Any]()
        var count:Int = 0
        Database.database().reference().child("ABTestingIconSelection").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            dictionaries.forEach({ (key, val) in
                print(key)
                print(val)
                if key == iconOption {
                    guard let existingCount = val as? [String: Any] else { return }
                    print(existingCount)
                    guard let cnt = existingCount["count"] as? Int else { return }
                    count += cnt
                    count += 1
                    values = ["count": count]
                    //update
                    ref.child("ABTestingIconSelection").child(iconOption).updateChildValues(values) { (err, ref) in
                        if let err = err {
                            print("error sending new icon count:",err)
                            return
                        }
                        self.present(messagePop(title: "Wooo!", message: "You can begin using GPYay!"), animated: true, completion: nil)
                    }
                }
            })
            values = ["count": count]
            print("new values:",values)
        }) { (err) in
            print("failed to fetch icon count:", err)
            print("not there?")
        }
    }
    
}
