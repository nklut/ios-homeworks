//
//  FeedViewController.swift
//  Navigation
//
//  Created by Nikita on 12.09.2024.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(button)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }
    
    private var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Open Post", for: .normal)
        return button
    }()
    
    
    

}
