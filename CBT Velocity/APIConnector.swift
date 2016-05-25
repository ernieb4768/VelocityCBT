//
//  APIConnector.swift
//  CBT Velocity
//
//  Created by Ryan Hoffman on 4/5/16.
//  Copyright © 2016 Ryan Hoffman. All rights reserved.
//

import Foundation

/**
  A class that is used to connect with the external database and retrieve necessary data. 
  It will pull the data in from a php script as a JSON array.
*/
class APIConnector {
    
    var image: String?
    var title: String?
    
    init(json: NSDictionary){
        self.image = json["IMAGE"] as? String
        self.title = json["DESCRIPTION"] as? String
    }

}