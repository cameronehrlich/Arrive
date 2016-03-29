//
//  RequestViewController.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/28/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    
    var flight: Flight?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(flight: Flight) {
        super.init(nibName: nil, bundle: nil)
        self.flight = flight
        print(flight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "Request Car"
        
    }
}

