//
//  CustomCell.swift
//  iOSCatchUp
//
//  Copyright © 2018 Tharindu. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var constrains: [NSLayoutConstraint] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let proPicImage: UIImageView = {
        
        let proImage = UIImageView()
        //proImage.backgroundColor = UIColor.blue
        proImage.layer.masksToBounds = true
        return proImage
    }()
    
    let profileName: UILabel = {
    
        let proName = UILabel()
        //proName.backgroundColor = UIColor.yellow
        return proName
        
    }()
    
    open let profileTimestamp: UILabel = {
        
        let proTime = UILabel()
        //proTime.backgroundColor = UIColor.red
        return proTime
        
    }()
    
    let profileDes: UILabel = {
        
        let proDes = UILabel()
        //proDes.backgroundColor = UIColor.green
        proDes.lineBreakMode = NSLineBreakMode.byWordWrapping
        proDes.numberOfLines = 10
        proDes.textColor = UIColor.lightGray
        return proDes
        
    }()
    
    let proDetailImage: UIImageView = {
        
        let detailImage = UIImageView()
        //detailImage.backgroundColor = UIColor.blue
        detailImage.layer.masksToBounds = true
        return detailImage
    }()
    
    func setupView() {
        addSubview(proPicImage)
        addSubview(profileName)
        addSubview(profileTimestamp)
        addSubview(profileDes)
        addSubview(proDetailImage)
        
        addConstraints(withVisualFormat: "H:|-20-[v0(50)]-10-[v1]-20-|", views: proPicImage, profileName, profileDes)
        addConstraints(withVisualFormat: "V:|-40-[v0(50)]", views: proPicImage)
        addConstraints(withVisualFormat: "V:|-40-[v0(20)]", views: profileName)
        
        addConstraints(withVisualFormat: "H:|-20-[v0(50)]-10-[v1]-20-|", views: proPicImage, profileTimestamp)
        addConstraints(withVisualFormat: "V:|-70-[v0(20)]", views: profileTimestamp)
        
        addConstraints(withVisualFormat: "H:|-20-[v0]-20-|", views: profileDes)
        addConstraints(withVisualFormat: "V:|-110-[v0]", views: profileDes)

        addConstraints(withVisualFormat: "H:|-20-[v0]-20-|", views: proDetailImage)
        addConstraints(withVisualFormat: "V:|-270-[v0(130)]", views: proDetailImage)

    }
    
}


private extension UIView{

    func addConstraints(withVisualFormat format: String, views: UIView...){
    
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

}




