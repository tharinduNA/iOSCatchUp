//
//  NewsFeedDownloader.swift
//  iOSCatchUp
//
//  Copyright © 2018 Tharindu. All rights reserved.
//

import UIKit
import Alamofire

protocol FeedDownloaderDelegate: class {
    func getNewsFeed (_feed: [[String:Any]])
}

class FeedDownloader {
    
    private let newsFeedUrl = "https://api.androidhive.info/feed/feed.json"
    weak var delegate: FeedDownloaderDelegate?
    
    func makeRequest(){
        callApi()
    }
    
    private func parseData(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options:.allowFragments) as! [String: Any]
            
            let items = readableJSON["feed"] as! [[String: Any]]
           // self.mFeed = items
            delegate?.getNewsFeed(_feed: items)
        } catch {
            print(error)
        }
        
    }
    
    private func callApi() {
        let urlTo = newsFeedUrl
        Alamofire.request(URL.init(string: urlTo)! ).responseJSON(completionHandler: { response in
            self.parseData(JSONData: response.data!)            
        })
    }
    
}
