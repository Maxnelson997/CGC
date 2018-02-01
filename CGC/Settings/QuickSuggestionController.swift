//
//  QuickSuggestionController.swift
//  CGC
//
//  Created by Max Nelson on 1/31/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import Firebase

class QuickSuggestionController: UIViewController, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.count != 0 {
            textView.textColor = .white
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = "Say what you want to see in the next version, hit Send It, then come back an update later and you might see it."
            textView.textColor = UIColor(white: 0.6, alpha: 1)
        }
    }
    
    let label = TitleLabel(text: "From GPA to GP-YAY! 🌟", size: 18, alignment: .left)
    let feedback:UITextView = {
        let tf = UITextView()
//        tf.paddingLeft = 8
//        tf.inset
        tf.text = "Say what you want to see in the next version, hit Send It, then come back an update later and you might see it."
        tf.textColor = UIColor(white: 0.6, alpha: 1)
        tf.backgroundColor = .blackPointEight
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.font = UIFont.init(name: "Futura", size: 16)
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Quick Suggestion"
        view.backgroundColor = .white
        feedback.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send It", style: .done, target: self, action: #selector(handleSend))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleDismiss))
        setupUI()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTF)))
    }
    
    @objc func handleSend() {
        if feedback.text == "Say what you want to see in the next version, hit Send It, then come back an update later and you might see it." || feedback.text.isEmpty || feedback.text == " " {
            present(messagePop(title: "Hold up..", message: "type something first broski. cmon."), animated: true, completion: nil)
        } else {
            sendUsingFirebase()
        }
    }
    
    fileprivate func sendUsingFirebase() {
        let ref = Database.database().reference()
        let values:[String:Any] = ["suggestion": feedback.text]
        ref.child("QuickSuggestions").childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                print("error sending feedback:",err)
                self.present(messagePop(title: "Dang Dood", message: "your amazing ideas couldn't be sent. Try again."), animated: true, completion: nil)
                return
            }
            self.present(messagePop(title: "Wooo!", message: "your amazing ideas have been sent to the developer"), animated: true, completion: nil)
            self.feedback.text = ""
        }
    }
    
    @objc private func dismissTF() {
        feedback.resignFirstResponder()
    }
    
    @objc func handleDismiss() {
        dismissTF()
        dismiss(animated: true, completion: nil)
    }
    


  

    
    private func setupUI() {
        view.addSubview(label)
        view.addSubview(feedback)
        
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 62, paddingBottom: 0, paddingRight: 58, width: 0, height: 0)
        feedback.anchor(top: label.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 58, paddingBottom: 0, paddingRight: 58, width: 0, height: 165)
        
    }
}
