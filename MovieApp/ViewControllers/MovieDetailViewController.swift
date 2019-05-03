//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

enum Items {
    case genre
    case language
}
class MovieDetailViewController: UIViewController {
    
    //MARK:- other variables
    
    var movieDetail: MovieInfoModel?
    var movieId = 0
    var genres = [String]()
    var languages = [String]()
    var actorInfos = [ActorInfo]()
    
    //MARK:- Outlets
    
    @IBOutlet weak var imgMoviePoster: CustomImageView!
    @IBOutlet weak var lblRunningTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTotalVotes: UILabel!
    @IBOutlet weak var lblAvgVote: UILabel!
    
    @IBOutlet weak var lblSynopsis: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    @IBOutlet weak var viewLanguages: UIView!
    @IBOutlet weak var viewGenre: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Methods
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let url = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(APIKey)&append_to_response=credits"
        let networkCall = NetworkHandler()
        networkCall.networkDelegate = self
        networkCall.fetchJSON(url: url)

        //Set Up the View
        var imgUrl = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movieDetail?.poster_path{
            imgUrl.append(posterPath)
        }
        imgMoviePoster.loadImageFromUrl(urlStr: imgUrl)
        lblTitle.text = movieDetail?.title
        lblTotalVotes.text = "\(movieDetail?.vote_count ?? 0)"
        lblAvgVote.text = "\(movieDetail?.vote_average ?? 0)"
        lblReleaseDate.text = movieDetail?.release_date
        lblSynopsis.text = movieDetail?.overview
        self.title = movieDetail?.title
        
        //setting up cast collectionview
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    //Handle the received data from cloud
    func handleData(details: [String:Any]){
        //fetching other required info needed for the page which is not available now
        self.lblRunningTime.text = "\(details["runtime"] ?? 0) min"
        let languageArray = details["spoken_languages"] as! [Any]
        print("languageArray ",languageArray)
        if languageArray.count == 0{
            self.languages.append(details["original_language"] as? String ?? "nil")
        } else {
            for i in 0..<languageArray.count{
                let lang = languageArray[i] as! [String:Any]
                print("lang dic ",lang)
                self.languages.append(lang["name"] as! String)
                
            } }
        let movieView = MovieDetailView()
        
        movieView.detailVIewController = self
        movieView.createElements(item: Items.language, elements: self.languages )
        let genreArray = details["genres"] as! [Any]
        print("genreArray ",genreArray)
        for i in 0..<genreArray.count{
            let genre = genreArray[i] as! [String:Any]
            let genreName = genre["name"] as! String
            self.genres.append(genreName)
            
        }
        movieView.createElements(item: Items.genre, elements: self.genres )
        //fetching cast info from the credits field
        let castInfo = (details["credits"] as! [String:Any])["cast"] as? [Any]
        //removing items to keep the limit to 5
        if castInfo?.count ?? 0 > 5 {
            let num = (castInfo?.count)! - 5
            let casts = castInfo?.dropLast(num)
            for i in casts!{
                let actorInfoDic = i as! [String:Any]
                let actorInfo = ActorInfo(photo: actorInfoDic["profile_path"] as? String ?? "nil", name: actorInfoDic["name"] as! String, role: actorInfoDic["character"] as! String)
                actorInfos.append(actorInfo)
                collectionView.reloadData()
            }
    }
}
}
extension MovieDetailViewController: NetWorkProtocol{
    func sendJSON(data: Data) {
        let data = data
        
        do{
            let details = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            print(details)
            DispatchQueue.main.async {
                // self.queryDone = true
                self.handleData(details: details)
                
            }
            
        } catch let jsonErr {
            print("error serialising json :",jsonErr)
        }
        
    }
    }
    
extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCVC
        cell.setUp(actorInfo: actorInfos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.6
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

