//
//  RemoteManager.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/25/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Timepiece

class RemoteManager {
    
    static let sharedManager = RemoteManager()
    
    private init() {
        // self.setup()
    }
    
    internal func fetchAirports(query: String, completion: (jsonResponse: JSON?, error: NSError?) -> Void) -> Request {
        
        let parameters = ["api_key" : K.IATACodes.apiKey, "query" : query]
        
        let request = Alamofire.request(.GET, K.IATACodes.baseUrl, parameters: parameters)
            .responseJSON { response in
                
                func failure(error: NSError) {
                    completion(jsonResponse: nil, error: error)
                }
                
                // Switch on request's success
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        completion(jsonResponse: JSON(value), error: nil)
                    }
                    else {
                        failure(response.result.error!)
                    }
                case .Failure(let error):
                    failure(error)
                }
        }
        
        return request
    }
    
    internal func fetchFlights(from: String, date: NSDate, completion: (jsonResponse: JSON?, error: NSError?) -> Void) -> Request {
        
        let dateString = [date.year, date.month, date.day, date.hour].componentsJoinedByString("/")
        
        let path = "airport/status/\(from)/dep/\(dateString)"
        
        let parameters = ["appId" : K.FlightTracker.appID, "appKey" : K.FlightTracker.appKey]
        
        let request = Alamofire.request(.GET, K.FlightTracker.baseUrl + path, parameters: parameters)
            .responseJSON { response in
                
                // Generalized failure handler
                func failure(error: NSError) {
                    completion(jsonResponse: nil, error: error)
                }
                
                // Switch on request's success
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        completion(jsonResponse: JSON(value), error: nil)
                    }
                    else {
                        failure(response.result.error!)
                    }
                case .Failure(let error):
                    failure(error)
                }
        }
        
        return request
    }
    
    // MARK: - Class
    
    class func dateFromString(dateString: String?) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let finalString = dateString {
            return dateFormatter.dateFromString(finalString)
        }
        return nil
    }
}
