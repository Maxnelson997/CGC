//
//  AboutController.swift
//  CGC
//
//  Created by Max Nelson on 2/1/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

enum fontType {
    case bold
    case regular
    case italic
}

class SocialIconCell:UICollectionViewCell {
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 7
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "ig")
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(iv)
        iv.anchorEntireView(to: contentView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AboutController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let ppIcon: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 7
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "GPYAYSmallIcon")
        return iv
    }()
    
    let icons = [#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "appstore"),#imageLiteral(resourceName: "linkedin"),#imageLiteral(resourceName: "ig"),#imageLiteral(resourceName: "stackoverflow"),#imageLiteral(resourceName: "github")]
    
    let social:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(SocialIconCell.self, forCellWithReuseIdentifier: "social")
        return cv
    }()


    let communityLabel = TitleLabel(text: "Community", size: 20, alignment: .left, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    let theAppLabel = TitleLabel(text: "The App", size: 20, alignment: .left, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    let communityText:UITextView = {
        let t = UITextView()
        t.text = "I am currently working on a website for GPYay that will allow everyone to comment, roast, compliment, or say whatever about the app. This will create a really cool community of awesome college students, high school students, and anyone using the app."
        t.font = UIFont.init(name: "Futura", size: 16)
        t.isEditable = false
        return t
    }()
    let textView:UITextView = {
        let t = UITextView()
        t.text = "GPYay started really simple and boring. Then semesters were introduced, but a lot of you were frustrated because sometimes the semesters would randomly delete. \nPaying close attention to what you wanted by reading every response and review, a couple updates later we have a high quality GPA Calculator app that isn't matched by any other on the App Store.\nSo if you write a review in the App Store you'll very likely see what you want in the next version. If you want, tap the icon above to write a review right now."
        t.font = UIFont.init(name: "Futura", size: 16)
        t.isEditable = false
        return t
    }()
    let developerText:UITextView = {
        let t = UITextView()
        t.text = "Max Nelson is 20 years old and attends Utah Valley University studying computer science, school is terrible, but has its benefits. He is thrilled by UI.UX design, mobile & web app development, photography, really good food, and chillin with the boys."
        t.font = UIFont.init(name: "Futura", size: 16)
        t.isEditable = false
        return t
    }()
    let theDeveloperLabel = TitleLabel(text: "The Developer", size: 20, alignment: .left, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About GPYay!"
        setupUI()
        social.delegate = self
        social.dataSource = self
    }
    
    @objc func handleReview() {
        self.openInBrowser(url: URL(string: "https://itunes.apple.com/us/app/college-gpa-calculator/id1112838673?ls=1&mt=8")!)
    }
    
    fileprivate func setupUI() {
        view.addSubview(communityLabel)
        view.addSubview(social)
        view.addSubview(communityText)
        view.addSubview(ppIcon)
        view.addSubview(theAppLabel)
        view.addSubview(textView)
        view.addSubview(theDeveloperLabel)
        view.addSubview(developerText)
        
        ppIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReview)))
        
        communityLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        social.anchor(top: communityLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 25, paddingRight: 16, width: 0, height: 100)
        communityText.anchor(top: communityLabel.topAnchor, left: view.centerXAnchor, bottom: ppIcon.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        theAppLabel.anchor(top: social.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        ppIcon.anchor(top: theAppLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 45, height: 45)
        textView.anchor(top: ppIcon.bottomAnchor, left: view.leftAnchor, bottom: view.centerYAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: -50, paddingRight: 16, width: 0, height: 0)
        theDeveloperLabel.anchor(top: textView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        developerText.anchor(top: theDeveloperLabel.bottomAnchor, left: view.leftAnchor, bottom: bottomLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: -10, paddingRight: 16, width: 0, height: 0)
        
//        ppIcon.anchor(top: topLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 40, height: 40)
    }


}


extension AboutController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "social", for: indexPath) as! SocialIconCell
        cell.iv.image = icons[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            goTo("twitter", "MaximusAsher")
        case 1:
            self.openInBrowser(url: URL(string: "http://apple.co/2BccnQE")!)
        case 2:
            self.openInBrowser(url: URL(string: "http://linkedin.com/in/maxwellnelson")!)
        case 3:
            goTo("instagram")
        case 4:
            self.openInBrowser(url: URL(string: "https://stackoverflow.com/users/3778273/max-nelson")!)
        case 5:
            self.openInBrowser(url: URL(string: "http://github.com/maxnelson997")!)
        default:
            break
        }
    }
    
    func goTo(_ app:String, _ username:String = "maxcodes") {
        let instagram = URL(string: "\(app)://user?username=\(username)")!
        if UIApplication.shared.canOpenURL(instagram) {
            UIApplication.shared.open(instagram, options: ["":""], completionHandler: { _ in })
        }
    }
    
    
    @objc func openInBrowser(url:URL) {
        //open in preferred browser
        //preferred browser is set in settings
        //defualt browser is safari.
        //use FAIcon for safari or chrome / preferred browser, ya feel Maxwell? ya I feel bruh. :D
        print("open in preferred browswer")
        
        var browser = "safari"
        if browser == "opera" {
            browser = "opera://open-url?url=http://"
        } else if browser == "firefox" {
            browser = "firefox://open-url?url=http://"
        } else if browser == "chrome" {
            browser = "googlechrome://"
        } else if browser == "safari" {
            browser = "safari://"
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        } else {
            view.showMessage(title: "preferred browser not installed.")
        }
    }
}
