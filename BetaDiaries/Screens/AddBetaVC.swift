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
    let sportLabel      = UILabel()
    let gradingLabel    = UILabel()
    let inOutLabel      = UILabel()
    let gradeLabel      = UILabel()
    let attemptsLabel   = UILabel()
    let locationLabel   = UILabel()
    
    var sportSelector   = UISegmentedControl()
    var gradeSelector   = UISegmentedControl()
    var inOutSelector   = UISegmentedControl()
    
    let attemptsStepper = UIStepper()
    let isSlabSwitch    = UISwitch()
    let gradePicker     = UIPickerView()
    let locationPicker  = UIPickerView()
    
    let ref             = Database.database().reference()
    
    let americanGrades  = [["V0","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15"], ["5.10a","5.10b","5.10c","5.10d","5.11a","5.11b","5.11c","5.11d","5.12a","5.12b","5.12c","5.12d","5.13a","5.13b","5.13c","5.13d","5.14a","5.14b","5.14c","5.14d","5.15a","5.15b","5.15c","5.15d"]]
    let europeanGrades  = [["4","4+","5","5+","6A","6A+","6B","6B+","6C","6C+","7A","7A+","7B","7B+","7C","7C+","8A","8A+","8B","8B+","8C","8C+","9A"], ["6A","6A+","6B","6B+","6C","6C+","7A","7A+","7B","7B+","7C","7C+","8A","8A+","8B","8B+","8C","8C+","9A","9A+","9B","9B+","9C"]]
    
    var indoorLocations     = ["Adamanta", "Amanecer", "BlocE", "RockSolid"]
    var outdoorLocations    = ["Salazar", "Chonta", "Yosemite", "Montserrat"]
    
    var delegate: ModalHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureBetaName()
        configureSportLabel()
        configureSportSelector()
        configureGradingLabel()
        configureGradeSelector()
        configureInOutLabel()
        configureInOutSelector()
        configureGradeLabel()
        configureGradePicker()
        configureAttemptsLabel()
        configureAttemptsStepper()
        configureIsSlabLabel()
        configureIsSlab()
        configureLocationLabel()
        configureLocationPicker()
        
        //configureBetaDescription()

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
            betaName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            betaName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            betaName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            betaName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSportLabel() {
        view.addSubview(sportLabel)
        sportLabel.translatesAutoresizingMaskIntoConstraints = false
        sportLabel.text = "Select sport:"
        
        NSLayoutConstraint.activate([
            sportLabel.topAnchor.constraint(equalTo: betaName.bottomAnchor, constant: 20),
            sportLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sportLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            sportLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    private func configureSportSelector() {
        let segments = ["Boulder", "Lead"]
        
        sportSelector                            = UISegmentedControl(items: segments)
        sportSelector.backgroundColor            = .secondarySystemBackground
        sportSelector.selectedSegmentIndex       = 0
        sportSelector.addTarget(self, action: #selector(changeGradingLabels), for: .valueChanged)
        
        sportSelector.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(sportSelector)
        
        NSLayoutConstraint.activate([
            sportSelector.topAnchor.constraint(equalTo: sportLabel.bottomAnchor,constant: 5),
            sportSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sportSelector.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20)
        ])
    }
    
    private func configureGradingLabel() {
        view.addSubview(gradingLabel)
        gradingLabel.translatesAutoresizingMaskIntoConstraints = false
        gradingLabel.text = "Select grading scale:"
        
        NSLayoutConstraint.activate([
            gradingLabel.topAnchor.constraint(equalTo: sportSelector.bottomAnchor, constant: 20),
            gradingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gradingLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            gradingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureGradeSelector() {
        let segments = ["V-scale", "Fontainebleau"]
        
        gradeSelector                            = UISegmentedControl(items: segments)
        gradeSelector.backgroundColor            = .secondarySystemBackground
        gradeSelector.selectedSegmentIndex       = 0
        gradeSelector.addTarget(self, action: #selector(reloadGradePicker), for: .valueChanged)
        
        gradeSelector.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(gradeSelector)
        
        NSLayoutConstraint.activate([
            gradeSelector.topAnchor.constraint(equalTo: gradingLabel.bottomAnchor,constant: 5),
            gradeSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gradeSelector.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20)
        ])
    }
    
    private func configureInOutLabel() {
        view.addSubview(inOutLabel)
        inOutLabel.translatesAutoresizingMaskIntoConstraints = false
        inOutLabel.text = "Select environment:"
        
        NSLayoutConstraint.activate([
            inOutLabel.topAnchor.constraint(equalTo: gradeSelector.bottomAnchor, constant: 20),
            inOutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inOutLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            inOutLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureInOutSelector() {
        let segments = ["Indoor", "Outdoor"]
        inOutSelector                            = UISegmentedControl(items: segments)
        inOutSelector.backgroundColor            = .secondarySystemBackground
        inOutSelector.selectedSegmentIndex       = 0
        inOutSelector.addTarget(self, action: #selector(reloadLocationPicker), for: .valueChanged)
        
        view.addSubview(inOutSelector)
        inOutSelector.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inOutSelector.topAnchor.constraint(equalTo: inOutLabel.bottomAnchor, constant: 5),
            inOutSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inOutSelector.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20)
        ])
    }
    
    private func configureGradeLabel() {
        view.addSubview(gradeLabel)
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gradeLabel.text = "Select grade:"
        
        NSLayoutConstraint.activate([
            gradeLabel.topAnchor.constraint(equalTo: betaName.bottomAnchor, constant: 20),
            gradeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            gradeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gradeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureGradePicker() {
        view.addSubview(gradePicker)
        gradePicker.translatesAutoresizingMaskIntoConstraints = false
        
        gradePicker.delegate            = self
        gradePicker.dataSource          = self
        gradePicker.layer.borderWidth   = 1.5
        gradePicker.layer.borderColor   = UIColor.systemGray2.cgColor
        gradePicker.layer.cornerRadius  = 10
        
        NSLayoutConstraint.activate([
            gradePicker.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            gradePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gradePicker.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 5),
            gradePicker.bottomAnchor.constraint(equalTo: inOutSelector.bottomAnchor)
            
        ])
    }
    
    private func configureAttemptsLabel() {
        view.addSubview(attemptsLabel)
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        attemptsLabel.text = "# of attempts: 1"
        
        NSLayoutConstraint.activate([
            attemptsLabel.topAnchor.constraint(equalTo: inOutSelector.bottomAnchor, constant: 40),
            attemptsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            attemptsLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            attemptsLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureAttemptsStepper() {
        view.addSubview(attemptsStepper)
        attemptsStepper.translatesAutoresizingMaskIntoConstraints = false
        
        attemptsStepper.minimumValue = 1.0
        attemptsStepper.maximumValue = 6.0
        attemptsStepper.addTarget(self, action: #selector(changeAttempts), for: .touchUpInside)

        NSLayoutConstraint.activate([
            attemptsStepper.centerYAnchor.constraint(equalTo: attemptsLabel.centerYAnchor),
            attemptsStepper.centerXAnchor.constraint(equalTo: gradePicker.centerXAnchor)
        ])
    }
    
    private func configureIsSlabLabel() {
        view.addSubview(isSlabLabel)
        isSlabLabel.translatesAutoresizingMaskIntoConstraints = false
        isSlabLabel.text = "Was it on a Slab?"
        
        NSLayoutConstraint.activate([
            isSlabLabel.topAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 40),
            isSlabLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            isSlabLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            isSlabLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureIsSlab() {
        view.addSubview(isSlabSwitch)
        isSlabSwitch.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            isSlabSwitch.centerXAnchor.constraint(equalTo: gradePicker.centerXAnchor),
            isSlabSwitch.centerYAnchor.constraint(equalTo: isSlabLabel.centerYAnchor)
        ])
        
    }
    
    private func configureLocationLabel() {
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Select location:"
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: isSlabLabel.bottomAnchor, constant: 40),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureLocationPicker() {
        view.addSubview(locationPicker)
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        locationPicker.delegate             = self
        locationPicker.dataSource           = self
        locationPicker.layer.borderWidth    = 1.5
        locationPicker.layer.borderColor    = UIColor.systemGray2.cgColor
        locationPicker.layer.cornerRadius   = 10
        
        NSLayoutConstraint.activate([
            locationPicker.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            locationPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationPicker.heightAnchor.constraint(equalToConstant: 200)
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
    
    @objc func addBeta() {
        
        guard betaName.text != nil else { return }
        guard betaDescription.text != nil else { return }
        
        ref.childByAutoId().setValue(["title": betaName.text!, "description": betaDescription.text!])
        
        
        dismiss(animated: true) {
            if let del = self.delegate {
                del.modalDismissed()
            }
        }
    }
    
    @objc func changeGradingLabels() {
        if sportSelector.selectedSegmentIndex == 0 {
            gradeSelector.setTitle("V-scale", forSegmentAt: 0)
            gradeSelector.setTitle("Fontainebleau", forSegmentAt: 1)
        } else {
            gradeSelector.setTitle("YDS", forSegmentAt: 0)
            gradeSelector.setTitle("French", forSegmentAt: 1)
        }
        gradePicker.reloadAllComponents()
    }
    
    @objc func reloadGradePicker() {
        gradePicker.reloadAllComponents()
    }
    
    @objc func reloadLocationPicker() {
        locationPicker.reloadAllComponents()
    }
    
    @objc func changeAttempts() {
        if attemptsStepper.value > 5 {
            attemptsLabel.text = "# of attempts: 6+"
        } else {
            attemptsLabel.text = "# of attempts: \(Int(attemptsStepper.value))"
        }
        
    }

}

extension AddBetaVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == gradePicker {
            if gradeSelector.selectedSegmentIndex == 0 {
                return americanGrades[sportSelector.selectedSegmentIndex].count
            } else {
                return europeanGrades[sportSelector.selectedSegmentIndex].count
            }
        } else if pickerView == locationPicker {
            if inOutSelector.selectedSegmentIndex == 0 {
                return indoorLocations.count
            } else {
                return outdoorLocations.count
            }
            
        } else {
            return 1
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == gradePicker {
            if gradeSelector.selectedSegmentIndex == 0 {
                return americanGrades[sportSelector.selectedSegmentIndex][row]
            } else {
                return europeanGrades[sportSelector.selectedSegmentIndex][row]
            }
        } else if pickerView == locationPicker {
            if inOutSelector.selectedSegmentIndex == 0 {
                return indoorLocations[row]
            } else {
                return outdoorLocations[row]
            }
        }
        return ""
        
        
    }
}

extension AddBetaVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == " Beta Description..." && textView.textColor == .lightGray)
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
            textView.text       = " Beta Description..."
            textView.textColor  = .lightGray
        }
        textView.resignFirstResponder()
    }
}
