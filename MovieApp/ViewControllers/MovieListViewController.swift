//
//  ViewController.swift
//  MovieApp
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit
let APIKey = "c22c19d0fcc92cc449cd6a92b2303f4e"
class MovieListViewController: UIViewController {
    //MARK:- Variables
    var pageNo = [1,1]
    var segmenterIndex = 0
    var selectedIndex = 0
    var nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKey)&language=en-US&page="
    var popularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey)&language=en-US&page="
    let searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey)&query="
    var urls = [String]()
    var queryDone = false
    var firstLoad = [true,true]
    //MARK:- Instances
    let networkCall = NetworkHandler()
   // var movielistViewModels  = [MovieListViewModel]()
    var movieListModel: MovieListModel?
    //MARK:- Methods
   /* func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }*/
    @objc func segmenterIndexChanged(sender: UISegmentedControl){
        print("segmenterIndexChangeds ",urls)
            segmenterIndex = sender.selectedSegmentIndex
            let url = urls[segmenterIndex]+"\(pageNo[segmenterIndex])"
            networkCall.fetchJSON(url: url)
    }
    
    fileprivate func setUpMovieListView() {
        MovieListView.movieListView.frame = self.view.frame
        self.view.addSubview(MovieListView.movieListView)
        MovieListView.movieListView.segmenter.addTarget(self, action: #selector(self.segmenterIndexChanged(sender:)), for: .valueChanged)
        MovieListView.movieListView.collectionView.delegate = self
        MovieListView.movieListView.collectionView.dataSource = self
        MovieListView.movieListView.collectionView.register(ListCVC.self)
        MovieListView.movieListView.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MovieApp"
        
        setUpMovieListView()
        urls.append(nowPlayingUrl)
        urls.append(popularUrl)
        
        let url = nowPlayingUrl+"\(pageNo[segmenterIndex])"
        networkCall.networkDelegate = self
        networkCall.fetchJSON(url: url)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let guest = segue.destination as! MovieDetailViewController
            guest.movieDetail = movieListModel?.results[selectedIndex]
            guest.movieId = movieListModel?.results[selectedIndex].id ?? 0
        }
    }
    //loads data when the user scrolls down
    @objc func loadData(){
        //let movieListView = MovieListView()
        MovieListView.movieListView.loadData()
    }
}

extension MovieListViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if queryDone{
        return (movieListModel?.results.count)!
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListCVC = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let movieInfo = movieListModel?.results[indexPath.row]
        cell.movieInfo = movieInfo
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height*0.3
        let width = collectionView.frame.width*0.45
        return CGSize(width: width, height: height)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: Any.self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == (movieListModel?.results.count)! - 1{
            print("displaying last item")
            if movieListModel?.page ?? 0 < movieListModel?.total_pages ?? 0 {
                pageNo[segmenterIndex]+=1
                let url = urls[segmenterIndex]+"\(pageNo[segmenterIndex])"
                
                networkCall.fetchJSON(url: url)
                perform(#selector(loadData), with: nil, afterDelay: 1.0)
            }
        }
    }
}
extension MovieListViewController: NetWorkProtocol{
    
    func sendJSON(data: Data) {
        let data = data
        print("sendJSON ",data)
        do{
            if firstLoad[segmenterIndex] {
                movieListModel = try JSONDecoder().decode(MovieListModel.self, from: data)
                firstLoad[segmenterIndex] = false
            }
            else{
           let movieList = try JSONDecoder().decode(MovieListModel.self, from: data)
                let results = movieList.results
                movieListModel?.results.append(contentsOf: results)
            }
            
           // print(movieListModel)
            DispatchQueue.main.async {
                self.queryDone = true
                
                self.loadData()
            
               // CustomLoader.activity.stopLoader()
            }
            
        } catch let jsonErr {
            print("error serialising json :",jsonErr)
        }
    }
}
extension MovieListViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
        let url = searchUrl+text
            firstLoad[segmenterIndex] = true
        networkCall.fetchJSON(url: url)
        }
        searchBar.endEditing(true)
    }
}

