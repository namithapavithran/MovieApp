//
//  MovieListView.swift
//  MovieApp
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

class MovieListView: UIView {
    static let movieListView = MovieListView()
    //MARK:- Instances
    
   /* var viewModel: MovieListViewModel
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }*/
    //MARK:- view declarations
    
    let searchBar:UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search with movie name"
        return view
    }()
    let segmenter:UISegmentedControl = {
        let view = UISegmentedControl(items: ["Now Playing","Most Popular"])
        view.selectedSegmentIndex = 0
    
        return view
    }()
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
       // layout.itemSize = CGSize(width: 60, height: 60)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return view
    }()
    
    func loadData(){
       MovieListView.movieListView.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpView(){
        let views: [String:UIView] = ["v0":searchBar,"v1":segmenter,"v2":collectionView]
        for (_,value) in views{
            value.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(value)
        }
        //Adding constraints
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        let verConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-15-[v1(40)]-15-[v2]-|", options: [], metrics: nil, views: views)
        self.addConstraints(verConstraint)
        let horConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v0]-15-|", options: [], metrics: nil, views: views)
        self.addConstraints(horConstraint1)
        let horConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v1]-15-|", options: [], metrics: nil, views: views)
        self.addConstraints(horConstraint2)
        let horConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v2]-15-|", options: [], metrics: nil, views: views)
        self.addConstraints(horConstraint3)
        self.backgroundColor = .white
    }
    
}


