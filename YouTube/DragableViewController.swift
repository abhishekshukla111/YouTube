//
//  VideoDetailViewController.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/17/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import UIKit

class DragableViewController: UIViewController {
    
    let imageView: DragableImageView = {
        let imageView = DragableImageView(frame: CGRect(x: 18, y: 120, width: 300, height:200))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "bulletTrain")
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Image View is dragable anywhere in the screen"
        label.numberOfLines = 0
        
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Dragable View"
        
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }
}
