//
//  HomeViewModel.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/16/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation
import UIKit


struct YoutubeModel: Codable {
    var pages: [Page]
}

struct Page: Codable {
    var number: Int
    var data: [YouTubeData]
}

struct YouTubeData: Codable {
    var url: String
    var thumbURL: String
    var title: String
    var subTitle: String
    var vidoDuration: String
    var index: String
}

class HomeViewModel: NSObject {
    
    var reloadTable: ((_ indexPath: IndexPath) -> Void)?
    var showAlert: (()->Void)?
    var didSelectRowAtIndexPath: ((_ indexPath: IndexPath) -> Void)?
    
    var youTubeDataArray: [YouTubeData] = []
    
    var recordsArray:[Int] = Array()
    var limit = 20
    let totalEnteries = 100
    
    var page = 0
    
    override init() {
        super.init()
        
        if let dataArray =  getMockAPIResponse(forPage: page) {
            setup(dataArray: dataArray)
        }
    }
    
    private func setup(dataArray: [YouTubeData]) {
        
        for data in  dataArray {
            youTubeDataArray.append(data)
        }
        
    
        var index = 0
        while index < limit {
            recordsArray.append(index)
            index = index + 1
        }
    }
    
    private func getMockAPIResponse(forPage page: Int) -> [YouTubeData]?{
       
        if let path = Bundle.main.path(forResource: "MockYouTubeAPI", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let youTubeModel = try JSONDecoder().decode(YoutubeModel.self, from: data)
                
                if page < youTubeModel.pages.count {
                    let pageModel = youTubeModel.pages[page]
                    let youTubeData = pageModel.data
                    return youTubeData
                }
                
                return nil
                
            } catch let error{
                print("Error : \(error)")
                return nil
            }
        }
        
        return nil
    }
}


extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row \(youTubeDataArray[indexPath.row].index)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == youTubeDataArray.count - 1 {
            page = page + 1
            if let dataArray =  getMockAPIResponse(forPage: page) {
                
                //youTubeDataArray.replace(with: youTubeDataArray.array + dataArray)
                for data in  dataArray {

                    youTubeDataArray.append(data)
                }
                
                reloadTable?(indexPath)
            } else {
                showAlert?()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath?(indexPath)
    }
}
