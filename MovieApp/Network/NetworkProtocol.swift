//
//  NetworkProtocol.swift
//  MovieApp
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import Foundation
protocol NetWorkProtocol {
    func sendJSON(data: Data)
}

class NetworkHandler{
    
    var networkDelegate: NetWorkProtocol?
    
    func fetchJSON(url: String){
        
        guard let Url = URL(string: url) else{ return }
       // CustomLoader.activity.startLoader()
        URLSession.shared.dataTask(with: Url) { (data, response, error) in
            print("inside NetworkHandler")
            guard let data = data else { return }
            
            self.networkDelegate?.sendJSON(data: data)
            
            }.resume()
    }
    
    
}
