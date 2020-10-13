//
//  AddBetaVC.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 24/09/20.
//

import UIKit
import FirebaseDatabase

protocol ModalHandler {
  func modalDismissed()
}

class AddBetaVC: UIViewController {
    
    let betaName        = UITextField()
    let betaDescription = UITextView()
    let isSlabLabel     = UILabel()
    var sportSelector   = UISegmentedControl()
    let isSlabSwitch    = UISwitch()
    let gradePicker     = UIPickerView()
    let ref             = Database.database().reference()
    
    let americanGrades  = ["N/A","V0","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15"]
    let europeanGrades  = ["N/A","4","4+","5","5+","6A","6A+","6B","6B+","6C","6C+","7A","7A+","7B","7B+","7C","7C+","8A","8A+","8B","8B+","8C","8C+","9A"]
    
    var delegate: ModalHandler?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureBetaName()
        configureSportSelector()
        configureIsSlab()
        configureGradePicker()
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
    
    private func configureSportSelector() {
        let segments = ["Boulder", "Lead"]
        
        sportSelector                            = UISegmentedControl(items: segments)
        sportSelector.selectedSegmentTintColor   = .systemGreen
        sportSelector.backgroundColor            = .secondarySystemBackground
        sportSelector.selectedSegmentIndex       = 0
        sportSelector.addTarget(self, action: #selector(reloadPicker), for: .valueChanged)
        
        sportSelector.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(sportSelector)
        
        NSLayoutConstraint.activate([
            sportSelector.topAnchor.constraint(equalTo: betaName.bottomAnchor, constant: 20),
            sportSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sportSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func reloadPicker(){
        gradePicker.reloadAllComponents()
    }
    
    private func configureIsSlab() {
        view.addSubview(isSlabLabel)
        view.addSubview(isSlabSwitch)
        isSlabSwitch.translatesAutoresizingMaskIntoConstraints  = false
        isSlabLabel.translatesAutoresizingMaskIntoConstraints   = false
        
        isSlabLabel.text = "Slab:"
        
        NSLayoutConstraint.activate([
            isSlabLabel.topAnchor.constraint(equalTo: sportSelector.bottomAnchor, constant: 20),
            isSlabLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            isSlabLabel.widthAnchor.constraint(equalToConstant: 50),
            isSlabLabel.heightAnchor.constraint(equalToConstant: 30),
            
            isSlabSwitch.leadingAnchor.constraint(equalTo: isSlabLabel.trailingAnchor, constant: 20),
            isSlabSwitch.centerYAnchor.constraint(equalTo: isSlabLabel.centerYAnchor)
        ])
        
    }
    
    private func configureGradePicker() {
        view.addSubview(gradePicker)
        gradePicker.translatesAutoresizingMaskIntoConstraints = false
        gradePicker.delegate     = self
        gradePicker.dataSource   = self
        
        NSLayoutConstraint.activate([
            gradePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gradePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gradePicker.topAnchor.constraint(equalTo: isSlabLabel.bottomAnchor, constant: 20)
            
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
            betaDescription.topAnchor.constraint(equalTo: gradePicker.bottomAnchor, constant: 20),
            betaDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            betaDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            betaDescription.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func addBeta(){
        
        guard betaName.text != nil else { return }
        guard betaDescription.text != nil else { return }
        
        ref.childByAutoId().setValue(["title": betaName.text!, "description": betaDescription.text!])
        
        
        dismiss(animated: true) {
            if let del = self.delegate {
                del.modalDismissed()
            }
        }
    }
    

}

extension AddBetaVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if sportSelector.selectedSegmentIndex == 0 {
            return americanGrades.count
        } else {
            return europeanGrades.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if sportSelector.selectedSegmentIndex == 0 {
            return americanGrades[row]
        } else {
            return europeanGrades[row]
        }
    }
}

extension AddBetaVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Beta Description..." && textView.textColor == .lightGray)
        {
            textView.text       = ""
            textView.textColor  = .label
        }
        textView.becomeFirstResponder()
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text       = "Beta Description..."
            textView.textColor  = .lightGray
        }
        textView.resignFirstResponder()
    }
}
