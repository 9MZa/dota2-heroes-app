//
//  DetailViewController.swift
//  Dota2 Hero
//
//  Created by Bandit Silachai on 4/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name: String?
    var image: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 40, weight: .black)

        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        
        
        if let imageURL = URL(string: image) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
           
        
        return view
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(nameLabel)
        view.addSubview(imageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 125
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
}

