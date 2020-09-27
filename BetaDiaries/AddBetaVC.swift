//
//  AddBetaVC.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 24/09/20.
//

import UIKit
import FirebaseDatabase

class AddBetaVC: UIViewController {
    
    let betaName        = UITextField()
    let betaDescription = UITextView()
    let ref             = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureBetaName()
        configureBetaDescription()

    }
    
    
    private func configureVC() {
        view.backgroundColor                =   .systemBackground
        title                               = "Add Beta"
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBeta))
    }
    
    private func configureBetaName() {
        view.addSubview(betaName)
        betaName.translatesAutoresizingMaskIntoConstraints = false
        betaName.layer.cornerRadius          = 10
        betaName.layer.borderWidth           = 2
        betaName.layer.borderColor           = UIColor.systemGray4.cgColor
        
        betaName.textColor                   = .label
        betaName.tintColor                   = .label
        betaName.textAlignment               = .center
        betaName.font                        = UIFont.preferredFont(forTextStyle: .title2)
        
        betaName.adjustsFontSizeToFitWidth   = true
        betaName.backgroundColor             = .tertiarySystemBackground
        betaName.autocorrectionType          = .no
        betaName.returnKeyType               = .go
        betaName.clearButtonMode             = .whileEditing
        betaName.placeholder                 = "Beta Name"
        
        NSLayoutConstraint.activate([
            betaName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            betaName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            betaName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            betaName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBetaDescription() {
        view.addSubview(betaDescription)
        betaDescription.translatesAutoresizingMaskIntoConstraints = false
        betaDescription.layer.cornerRadius  = 10
        betaDescription.layer.borderWidth   = 2
        betaDescription.layer.borderColor   = UIColor.systemGray4.cgColor
        betaDescription.delegate            = self
        
        betaDescription.textColor           = .lightGray
        betaDescription.tintColor           = .label
        betaDescription.textAlignment       = .left
        betaDescription.font                = UIFont.preferredFont(forTextStyle: .title2)
        
        betaDescription.backgroundColor     = .tertiarySystemBackground
        betaDescription.isEditable          = true
        betaDescription.text                = "Beta Description..."
        betaDescription.autocorrectionType  = .no
        
        NSLayoutConstraint.activate([
            betaDescription.topAnchor.constraint(equalTo: betaName.bottomAnchor, constant: 100),
            betaDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            betaDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            betaDescription.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func addBeta(){
        
        guard betaName.text != nil else { return }
        guard betaDescription.text != nil else { return }
        
        ref.childByAutoId().setValue(["title": betaName.text!, "description": betaDescription.text!])
        
        
        dismiss(animated: true)
    }
    

}

extension AddBetaVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Beta Description..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .label
        }
        textView.becomeFirstResponder()
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Beta Description..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
