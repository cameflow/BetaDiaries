//
//  ViewController.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 19/09/20.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController{

    
    
    let tableView       = UITableView()
    var betas:[String]  = []
    var counter         = 0
    let ref             = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
        
    
    func getData() {
        betas.removeAll()
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as! [String:[String:Any]]
            for (_, value) in data {
                self.betas.append(value["title"] as! String)
            }
            self.betas.sort()
            self.tableView.reloadData()
        }
        
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Beta Diaries"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBeta))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BetaCell")
    }
    
    @objc func addBeta() {
        
        let destVC = AddBetaVC()
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
    


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return betas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetaCell")!
        cell.textLabel?.text = betas[indexPath.row]
        return cell
    }
    
}

extension ViewController: ModalHandler {
    func modalDismissed() {
        getData()
    }
}




