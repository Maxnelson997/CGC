//
//  UpgradeController.swift
//  CGC
//
//  Created by Max Nelson on 2/2/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import StoreKit
import PopupDialog

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
        layer.cornerRadius = 10
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
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
            "Unlimited Themes",
            "Tuition costs you thousands of dollars",
            "And yeah, the icons are pretty dope",
            "Restore",
            "Get"
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
//        cell.backgroundColor = .clear
//        cell.label.textColor = .black
        if indexPath.item == reasons.count - 2 {
            //restore
            cell.backgroundColor = DefaultValues.shared.themeColor
            cell.label.textColor = DefaultValues.shared.themeTitleColor
            cell.label.textAlignment = .center
        } else if indexPath.item == reasons.count - 1 {
            //purchase
            cell.backgroundColor = UIColor.appleBlue
            cell.label.textColor = UIColor.white
            cell.label.textAlignment = .center
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 110)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! IconHeader
            let attributedText = NSMutableAttributedString(string: "Dope Edition\n", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedText.append(NSAttributedString(string: "Tuition is thousands of dollars. Could help you save thousands by helping you pass classes. for some pocket change. #investment.", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Futura", size: 16)!]))
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
    func checkPurchases() {
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_PURCHASE_DOPE_EDITION) {
            DefaultValues.shared.isUserFreemium = false
        } else {
            DefaultValues.shared.isUserFreemium = true //TESTTHIS
        }
    }
    func restore() {
        print("trying to restore")
        let loading = NVActivityIndicatorView(frame: CGRect(x: view.frame.width/2 - 20, y: view.frame.height/2 - 20, width: 40, height: 40), type: .ballRotateChase, color: .white)
        view.addSubview(loading)
        loading.startAnimating()
        PurchaseManager.instance.restorePurchases { success in
            loading.stopAnimating()
            if success {
                self.checkPurchases()
                //dopness achieved
                let pop = PopupDialog(title: "Dopeness Achieved", message: "Dope Edition successfuly restored.")
                self.present(pop, animated: true, completion: nil)
                delay(4, closure: {
                    pop.dismiss()
                })
            } else {
                let pop = PopupDialog(title: "Dopeness Not Achieved", message: "Something went wrong.")
                self.present(pop, animated: true, completion: nil)
                delay(4, closure: {
                    pop.dismiss()
                })
            }
        }
    }
    
    func purchase() {
        print("trying to purchase")

        let loading = NVActivityIndicatorView(frame: CGRect(x: view.frame.width/2 - 20, y: view.frame.height/2 - 20, width: 40, height: 40), type: .ballRotateChase, color: .white)
        view.addSubview(loading)
        loading.startAnimating()
        PurchaseManager.instance.purchaseDopeEdition { success in
            //dismiss spinner
            loading.stopAnimating()
            var pop:PopupDialog!
            if success {
                //dopness achieved
                pop = PopupDialog(title: "Dopeness Achieved", message: "Dope Edition successfuly purchased.")
            } else {
                pop = PopupDialog(title: "Dopeness Not Achieved", message: "Purchase Failed, try again.")
                //tell user dopeness could not be achieved at this time #failed
            }
            self.present(pop, animated: true, completion: nil)
            delay(4, closure: {
                pop.dismiss()
            })
            
        }
        
    }
    



    
}

