//
//  ViewController.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 19/09/20.
//

import UIKit

class ViewController: UIViewController{

    
    
    let tableView = UITableView()
    var betas:[String]  = []
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
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
        print("Betta Added")
        betas.append("Beta # \(counter)")
        counter += 1
        tableView.reloadData()
        let destVC = AddBetaVC()
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
