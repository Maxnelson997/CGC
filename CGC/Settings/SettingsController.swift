//
//  SettingsController.swift
//  CGC
//
//  Created by Max Nelson on 1/26/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit


func confirmationPopup(title: String, message: String, confirmTitle:String = "confirm", completion: @escaping () -> ()) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
    alertController.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { (action) in
        completion()
    }))
    return alertController
}

func messagePop(title: String, message:String? = "") -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    return alertController
}

class SettingCell:UITableViewCell {
    
    var settingsController:SettingsController?
    let bg:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.init(red: 200, green: 200, blue: 200).withAlphaComponent(0.1)
        return v
    }()
    
    var option:Option? {
        didSet {
            guard let option = option else { return }
            guard let settingsController = settingsController else { return }
            iconImageView.image = option.icon
            optionLabel.attributedText = NSMutableAttributedString(string: option.title, attributes: [NSAttributedStringKey.font:UIFont.init(name: "Futura-Bold", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            self.addGestureRecognizer(UITapGestureRecognizer(target: settingsController, action: option.selector))
        }
    }
    
    var iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var optionLabel:TitleLabel = {
        let l = TitleLabel()
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bg)
        addSubview(iconImageView)
        addSubview(optionLabel)
        
        bg.anchorEntireView(to: self)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        optionLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

struct Option {
    var title:String
    var icon:UIImage
    var selector:Selector
}

struct OptionSection {
    var title:String
    var options:[Option]
}

class SettingsController: UITableViewController {
    
    var cellId:String = "cellId"
    
    var options = [OptionSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        navigationItem.title = "More Stuff"
        view.backgroundColor = .clear
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    var isSelectingTheme:Bool = false
    
    @objc func themeTapped() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let themeController = ThemeController(collectionViewLayout: layout)
        let themeNav = CustomNavController(rootViewController: themeController)
        present(themeNav, animated: true, completion: nil)
    }
    
    @objc func quickSuggestionTapped() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let QSC = QuickSuggestionController()
        let QSV = CustomNavController(rootViewController: QSC)
        present(QSV, animated: true, completion: nil)
    }
    
    @objc func instagramTapped() {
        let instagram = URL(string: "instagram://user?username=maxcodes")!
        if UIApplication.shared.canOpenURL(instagram) {
            UIApplication.shared.open(instagram, options: ["":""], completionHandler: { _ in

            })
        }
    }
    
    @objc func aboutTapped() {
        let aboutController = AboutController()
        navigationController?.pushViewController(aboutController, animated: true)
    }
    
    @objc func defaultSelector() {
        print("trying to perform option action")
    }
    
    @objc func clearSemesters() {
        let pop = confirmationPopup(title: "You sure fam?", message: "This will clear all your semesters and classes.", confirmTitle: "clear") {
            CoreDataManager.shared.clearSemesters()
            //super hacky but I wanted to do it this way
            (((UIApplication.shared.delegate as! AppDelegate).tab.viewControllers![0] as! UINavigationController).topViewController as! SemestersController).semesters = []
            self.present(messagePop(title: "semesters cleared"), animated: true, completion: nil)
        }
        present(pop, animated: true, completion: nil)
    }
    
    @objc func clearClasses() {
        let pop = confirmationPopup(title: "You sure fam?", message: "This will clear all your classes and leave your semesters empty.", confirmTitle: "clear") {
            CoreDataManager.shared.clearClasses()
            self.present(messagePop(title: "classes cleared"), animated: true, completion: nil)
        }
        present(pop, animated: true, completion: nil)
    }
    
    @objc func websiteTapped() {
        let instagram = URL(string: "http://www.maxthedev.com")!
        if UIApplication.shared.canOpenURL(instagram) {
            UIApplication.shared.open(instagram, options: ["":""], completionHandler: { _ in
                
            })
        }
    }
    
    @objc func changeIconTapped() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let FLC = FirstLaunchController(collectionViewLayout: layout)
        let FLC_NAV = CustomNavController(rootViewController: FLC)
        present(FLC_NAV, animated: true, completion: nil)
    }
    
//     #imageLiteral(resourceName: "s75") theme stars
//    #imageLiteral(resourceName: "f15") pencil
    
//    #imageLiteral(resourceName: "e4") back to school
//    #imageLiteral(resourceName: "emoj42")
    func setupData() {
        let firstOptions = [
            Option(title: "Clear semesters", icon: #imageLiteral(resourceName: "a41"), selector: #selector(clearSemesters)),
            Option(title: "Clear classes", icon: #imageLiteral(resourceName: "s46"), selector: #selector(clearClasses)),
        ]
        let secondOptions = [
//            Option(title: "Set grade values", icon: #imageLiteral(resourceName: "shooting-star"), selector: #selector(defaultSelector)),
            Option(title: "Theme", icon:#imageLiteral(resourceName: "s60"), selector: #selector(themeTapped)),
            Option(title: "App Icon", icon:#imageLiteral(resourceName: "appstore"), selector: #selector(changeIconTapped)),
        ]
        let thirdOptions = [
            Option(title: "Quick Suggestion", icon: #imageLiteral(resourceName: "f13"), selector: #selector(quickSuggestionTapped)),
            Option(title: "Community", icon: #imageLiteral(resourceName: "f20"), selector: #selector(instagramTapped)),
            Option(title: "About", icon: #imageLiteral(resourceName: "u4"), selector: #selector(aboutTapped)),
            Option(title: "Developer website", icon: #imageLiteral(resourceName: "s45"), selector: #selector(websiteTapped))
        ]
        let firstSection = OptionSection(title: "Storage", options: firstOptions)
        let secondSection = OptionSection(title: "Customize", options: secondOptions)
        let thirdSection = OptionSection(title: "Extra", options: thirdOptions)
        options = [firstSection, secondSection, thirdSection]
    }
    
}


extension SettingsController {
    //tableview delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingCell
        cell.settingsController = self
        cell.option = options[indexPath.section].options[indexPath.item]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
//        cell.backgroundColor = UIColor(white: 0.5, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TitleLabel(text: options[section].title, size: 25, alignment: .left, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        header.backgroundColor = UIColor(white: 0.5, alpha: 0)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}



