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

class AirportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    let tableView = UITableView(forAutoLayout: ())
    let fetchedResultsController = CoreManager.sharedManager.airportSearchFetchedResultsController()
    var searchRequest: Request?
    
    let searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.searchBarStyle = .Minimal
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = "Where are you departing from?"
        controller.searchBar.tintColor = UIColor(red:0.39, green:0.25, blue:0.49, alpha:1.00)
        return controller
    })()
    
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
        tableView.keyboardDismissMode = .Interactive
        tableView.registerClass(AirportTableViewCell.self, forCellReuseIdentifier: AirportTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        // Configure searchController
        searchController.searchResultsUpdater = self
        fetchedResultsController.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        
        //        CoreManager.sharedManager.fetchDepartures("ORD", departureDate: NSDate())


    }
    
    // MARK : - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (fetchedResultsController.sections?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultsController.fetchedObjects?.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AirportTableViewCell.identifier, forIndexPath: indexPath) as! AirportTableViewCell
        if let airport: Airport = fetchedResultsController.fetchedObjects![indexPath.item] as? Airport {
            configureCell(cell, airport: airport)
        }
        
        return cell
    }
    
    func configureCell(cell: AirportTableViewCell, airport: Airport) -> Void {
        cell.textLabel?.text = airport.airportCode
        cell.detailTextLabel?.text = airport.name
    }
    
    // MARK : - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select cell \(indexPath)")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("did deselect cell \(indexPath)")
    }


    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            break
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            break
        case .Update:
            
            if let cell = tableView.cellForRowAtIndexPath(indexPath!)! as? AirportTableViewCell {
                if let airport: Airport = fetchedResultsController.fetchedObjects![indexPath!.item] as? Airport {
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
        else {
            print("Nothing to search for")
            // Delete current resutls
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



