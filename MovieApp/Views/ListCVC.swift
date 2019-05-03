//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

class ListCVC: UICollectionViewCell {
    var movieInfo: MovieInfoModel! {
        didSet{
            var urlStr = "https://image.tmdb.org/t/p/w500/"
            if let posterPath = movieInfo.poster_path{
                urlStr.append(posterPath)
            }
           // urlStr.append(movieInfo.poster_path!)
            imgLogo.loadImageFromUrl(urlStr: urlStr)
            lblName.text = movieInfo.title
            lblScore.text = "vote avg \(movieInfo.vote_average ?? 0)"
        }
    }
    let imgLogo: CustomImageView =
    {
        let imgView = CustomImageView()
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "moview name"
        return lbl
    }()
    let lblScore: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "score"
        return lbl
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    func setUpView(){
        
        let views: [String:UIView] = ["v0":imgLogo,"v1":lblName,"v2":lblScore]
        for (_,value) in views{
            self.contentView.addSubview(value)
            value.translatesAutoresizingMaskIntoConstraints = false
        }
        let metric = ["imgHeight": self.contentView.frame.height*0.7]
        let verConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0(imgHeight)]-[v1]-[v2]", options: [], metrics: metric, views: views)
         self.contentView.addConstraints(verConstraint)
        let horConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: [], metrics: nil, views: views)
         self.contentView.addConstraints(horConstraint1)
        let horConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1]-|", options: [], metrics: nil, views: views)
         self.contentView.addConstraints(horConstraint2)
        let horConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v2]-|", options: [], metrics: nil, views: views)
         self.contentView.addConstraints(horConstraint3)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
