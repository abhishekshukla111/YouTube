//
//  HomeModel.swift
//  YouTube
//
//  Created by Abhishek Shukla on 6/17/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation

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
