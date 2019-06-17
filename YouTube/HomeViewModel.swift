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
    
    var reloadTable: (() -> Void)?
    var showAlert: (()->Void)?
    var didSelectRowAtIndexPath: ((_ indexPath: IndexPath) -> Void)?
    
    var youTubeDataArray: [YouTubeData] = []
    var fetchingMore = false
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
            self.page = self.page + 1
            if let dataArray =  self.getMockAPIResponse(forPage: self.page) {
                for data in  dataArray {
                    self.youTubeDataArray.append(data)
                }
                self.fetchingMore = false
                self.reloadTable?()
            } else {
                self.showAlert?()
            }
        })
    }
}


extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell

        let dataModel = youTubeDataArray[indexPath.row]
        
        cell.thumbnailImageView.image = UIImage(named: dataModel.thumbURL)
        cell.titleLabel.text = dataModel.title
        //cell.textLabel?.text = "Row \(youTubeDataArray[indexPath.row].index)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == youTubeDataArray.count - 1 {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath?(indexPath)
    }
}
