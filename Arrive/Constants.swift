//
//  Constants.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/24/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import Foundation

// Interesting way of managing global constants that I found on SO. http://stackoverflow.com/questions/26252233/global-constants-file-in-swift

struct K {
    struct FlightTracker {
        static let baseUrl = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/"
        static let appID = "0ec13b93"
        static let appKey = "ab3e8107b1c0abaa933d45e0b1e7f11b"
    }
    
    struct IATACodes {
        static let baseUrl = "http://iatacodes.org/api/v4/autocomplete"
        static let apiKey = "0030abb7-a53e-4445-80dc-28034bf635ab"
    }
}