//
//  AirportSearchViewController.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/24/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit
import CoreData
import PureLayout
import Alamofire

class AirportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    var searchRequest: Request?
    let continueButton: UIButton = UIButton(type: .Custom)

    let tableView = UITableView(forAutoLayout: ())
    let fetchedResultsController = CoreManager.sharedManager.airportSearchFetchedResultsController()
    
    let searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.dimsBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        controller.searchBar.searchBarStyle = .Minimal
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = "Where are you departing from?"
        controller.searchBar.tintColor = UIColor.sk_purpleColor()
        controller.searchBar.returnKeyType = .Search
        return controller
    })()
    
    // Mark - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreManager.sharedManager.setup()
        
        // Configure titleView
        let logo = UIImage(named: "p_m_skurt-logo")
        let imageView = UIImageView(image:logo)
        navigationItem.titleView = imageView
        
        // Configure tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(AirportTableViewCell.self, forCellReuseIdentifier: AirportTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        // Configure searchController
        searchController.searchResultsUpdater = self
        fetchedResultsController.delegate = self
        tableView.tableHeaderView = searchController.searchBar
                
        let toolbar = UIToolbar(forAutoLayout: ())
        toolbar.barStyle = .Default
        toolbar.barTintColor = UIColor.sk_purpleColor()
        
        continueButton.bounds = CGRectMake(0, 0, view.bounds.width, toolbar.intrinsicContentSize().height)
        continueButton.titleLabel!.font = UIFont.sk_boldFont(22)
        continueButton.setTitle("Continue", forState: .Normal)
        continueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        continueButton.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.75), forState: .Highlighted)
        continueButton.titleLabel!.textAlignment = .Center
        continueButton.addTarget(self, action: #selector(AirportSearchViewController.continueAction(_:)), forControlEvents: .TouchUpInside)
    
        let barButtonItem = UIBarButtonItem(customView: continueButton)
        barButtonItem.target = self
        barButtonItem.action = #selector(AirportSearchViewController.continueAction(_:))
        
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            barButtonItem,
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        ]
        
        searchController.searchBar.inputAccessoryView = toolbar
        deselectAllRows()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchController.active = true
        searchController.searchBar.becomeFirstResponder()
    }
    
    func continueAction(sender: UIButton?) -> Void {
        searchController.active = false
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if let airport = fetchedResultsController.fetchedObjects![selectedIndexPath.item] as? Airport {
                let viewController = FlightSelectionViewController(airportCode: airport.airportCode!)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        else {
            print("you need to select an airport first!")
        }
    }
    
    // MARK : - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (fetchedResultsController.sections?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultsController.fetchedObjects?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AirportTableViewCell.identifier, forIndexPath: indexPath) as! AirportTableViewCell
        if let airport = fetchedResultsController.fetchedObjects![indexPath.item] as? Airport {
            configureCell(cell, airport: airport)
        }
        return cell
    }
    
    func configureCell(cell: AirportTableViewCell, airport: Airport) -> Void {
        cell.textLabel?.text = airport.airportCode
        cell.detailTextLabel?.text = airport.name
    }
    
    // MARK : - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        continueButton.alpha = 1.0
    }

    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        deselectAllRows()
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            break
        case .Update:
            if let cell = tableView.cellForRowAtIndexPath(indexPath!)! as? AirportTableViewCell {
                if let airport = fetchedResultsController.fetchedObjects![indexPath!.item] as? Airport {
                    configureCell(cell, airport: airport)
                }
            }
            break
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let text: String = searchController.searchBar.text! as String {
            if searchRequest != nil {
                searchRequest?.cancel()
                searchRequest = nil
            }
            
            CoreManager.sharedManager.resetAirports()
            searchRequest = CoreManager.sharedManager.fetchAirports(text)
        }
    }
    
    internal func deselectAllRows() -> Void {
        if let indexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
        
        continueButton.alpha = 0.3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



