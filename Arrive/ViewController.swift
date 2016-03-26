//
//  ViewController.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/24/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var didSetupConstraints = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreManager.sharedManager.setup()
        
        let logo = UIImage(named: "p_m_skurt-logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        CoreManager.sharedManager.fetchDepartures("LAX", departureDate: NSDate())
    }
    
    override func updateViewConstraints() {
        
        
        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

