//
//  HomeTableViewCell.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/16/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ])
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
