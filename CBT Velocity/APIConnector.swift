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
    
    static func getData() -> NSHTTPURLResponse {
        let url = "http://173.91.95.14/getAllActivities.php"
        var httpResponseReturn: NSHTTPURLResponse!
        let requestURL: NSURL = NSURL(string: url)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                httpResponseReturn = httpResponse
            }
            
        }
        task.resume()
        return httpResponseReturn
    }

}