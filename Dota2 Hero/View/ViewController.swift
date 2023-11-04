//
//  ViewController.swift
//  Dota2 Hero
//
//  Created by Bandit Silachai on 4/11/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let viewModel = HeroViewModel()
    var heroes: [Hero]?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "hero")
        viewModel.getHeroes { [weak self] result in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.updateUI()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        setupUI()
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let heroes = heroes {
            return heroes.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hero", for: indexPath)
        if let heroes = heroes {
            cell.textLabel?.text = heroes[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if heroes != nil {
            let detailVC = DetailViewController()
            detailVC.name = heroes![indexPath.row].name
            detailVC.image = heroes![indexPath.row].smallThumbnail
            self.present(detailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

