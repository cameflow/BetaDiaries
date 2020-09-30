//
//  BetaDetailVC.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 29/09/20.
//

import UIKit

class BetaDetailVC: UIViewController {
    
    var titleLabel       = UILabel()
    var descriptionLabel = UITextView()
    var beta: Beta!
    
    init (beta: Beta) {
        super.init(nibName: nil, bundle: nil)
        self.beta = beta
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureDescriptionLabel()

    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text             = beta?.name
        titleLabel.textAlignment    = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        
    }
    
    func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = beta.description
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        
        
    }
    
    


}
