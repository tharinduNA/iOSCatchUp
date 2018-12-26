//
//  ViewController.swift
//  iOSCatchUp
//
//  Copyright © 2018 Tharindu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, FeedDownloaderDelegate{

    let cellIdentifier = "cell"


    var mFeed = [[String:Any]]()
    
    func getNewsFeed (_feed dowloadedFeed: [[String:Any]] ) {
        self.mFeed = dowloadedFeed
        self.collectionView.reloadData()
    }
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        return cv
        
    }()

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = FeedDownloader()
        client.delegate = self
        client.makeRequest()
        
        view.backgroundColor = UIColor.red
        setupController()
        
        collectionView.register(CustomCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func setupController() {
        
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.mFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CustomCell
        cell.backgroundColor = UIColor.white

        
        let dictionary = self.mFeed[indexPath.row] as [String:Any]
        
        if let name = dictionary["name"] as? String {
            cell.profileName.text = name
        }
        
        if let status = dictionary["status"] as? String {
            cell.profileDes.text = status
        }
        
        
        if let timeStamp = dictionary["timeStamp"] as? String {
            cell.profileTimestamp.text = timeStamp
        }

        
        
        //TODO: to be removed upon image downloader
        if let proPic = dictionary["profilePic"] as? String {
            Alamofire.request(proPic).responseImage {
                response in
                if let image = response.result.value {
                    cell.proPicImage.image = image
                }
            }
        }
        
        if let img = dictionary["image"] as? String {
            Alamofire.request(img).responseImage {
                response in
                if let image = response.result.value {
                    cell.proDetailImage.image = image
                }
            }
        }
 
        
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
}





