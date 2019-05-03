//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    
    var detailVIewController: MovieDetailViewController?
    
    func createElements(item: Items,elements: [String]){
        var x = 10
        var width = 50
        for i in 0..<elements.count{
            let label = UILabel()
            label.textColor = .white
            label.layer.borderColor = UIColor.white.cgColor
            label.layer.borderWidth = 1
            label.text = elements[i]
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            if item == Items.genre{
                detailVIewController?.viewGenre.addSubview(label)
                label.leadingAnchor.constraint(equalTo: (detailVIewController?.viewGenre.leadingAnchor)!, constant: CGFloat(x)).isActive = true
                label.centerYAnchor.constraint(equalTo: (detailVIewController?.viewGenre.centerYAnchor)!).isActive = true
                width = elements[i].count*8
                label.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            }
            else{
                detailVIewController?.viewLanguages.addSubview(label)
                label.leadingAnchor.constraint(equalTo: (detailVIewController?.viewLanguages.leadingAnchor)!, constant: CGFloat(x)).isActive = true
                label.centerYAnchor.constraint(equalTo: (detailVIewController?.viewLanguages.centerYAnchor)!).isActive = true
                width = elements[i].count*8
                label.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            }
            x = x + width + 4
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
