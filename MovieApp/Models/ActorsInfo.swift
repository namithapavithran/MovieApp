//
//  ActorsInfo.swift
//  MovieApp
//
//  Created by user143649 on 4/19/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import Foundation

struct ActorInfo{
    let photo: String
    let name: String
    let role: String
    init(photo: String,name: String,role: String) {
        self.photo = photo
        self.name = name
        self.role = role
    }
}
