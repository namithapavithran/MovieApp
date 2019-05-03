//
//  CastCVC.swift
//  MovieApp
//
//  Created by user143649 on 4/19/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

class CastCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgPoster: CustomImageView!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblName: UILabel!
  
    func setUp(actorInfo: ActorInfo){
        lblName.text = actorInfo.name
        lblRole.text = actorInfo.role
        var urlStr = "https://image.tmdb.org/t/p/w500/"
        let posterPath = actorInfo.photo
            urlStr.append(posterPath)
       
        imgPoster.loadImageFromUrl(urlStr: urlStr)
       
    }
}
