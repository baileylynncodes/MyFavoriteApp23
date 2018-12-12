//
//  Post.swift
//  MyFavoriteApp23
//
//  Created by Karissa McDaris on 12/12/18.
//  Copyright © 2018 Karissa McDaris. All rights reserved.
//

import Foundation

struct Post: Codable {
    var name: String
    var favApp: String
    
    init(name: String, favApp: String) {
        self.name = name
        self.favApp = favApp
    }
    
    init?(dictionary: [String:String]){
       guard let name = dictionary["name"],
        let faveApp = dictionary["favApp"] else {return nil}
        
        self.name = name
        self.favApp = faveApp
    }
}
