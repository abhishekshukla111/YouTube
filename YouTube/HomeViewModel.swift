//
//  HomeViewModel.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/16/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation
import UIKit


class HomeViewModel: NSObject {
    
    var reloadTable: (()->Void)?
    
    var recordsArray:[Int] = Array()
    var limit = 20
    let totalEnteries = 100
    
    override init() {
        super.init()

        setup()
    }
    
    private func setup() {
        var index = 0
        while index < limit {
            recordsArray.append(index)
            index = index + 1
        }
    }
}


extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row \(recordsArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordsArray.count - 1 {
            // we are at last cell load more content
            if recordsArray.count < totalEnteries {
                // we need to bring more records as there are some pending records available
                var index = recordsArray.count
                limit = index + 20
                while index < limit {
                    recordsArray.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 0.1)
            }
        }
    }
    
    @objc func loadTable() {
        reloadTable?()
    }
    
}
