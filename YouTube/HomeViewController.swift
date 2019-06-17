//
//  ViewController.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/16/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "YouTube"
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        
        setupViewModel()

        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.reloadTable = {
            self.tableView.reloadData()
        }
        
        viewModel.showAlert = {
            let alert = UIAlertController(title: "Alert", message: "No More data available from API", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.didSelectRowAtIndexPath = { indexPath in
            let dragableViewController = DragableViewController()
            self.navigationController?.pushViewController(dragableViewController, animated: true)
            //self.present(detailViewController, animated: true, completion: nil)
        }
    }
}


