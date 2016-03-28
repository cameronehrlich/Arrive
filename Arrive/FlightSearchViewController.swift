//
//  FlightSearchViewController.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/28/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit
import CoreData
import PureLayout
import Alamofire

class FlightSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var airportCode: String?
    var flightsRequest: Request?
    
    let timePicker = UIPickerView(forAutoLayout: ())
    let tableView = UITableView(forAutoLayout: ())
    let fetchedResultsController = CoreManager.sharedManager.flightsFetchedResultsController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(airportCode: String) {
        super.init(nibName: nil, bundle: nil)
        self.airportCode = airportCode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor.whiteColor()
        title = "Select Departure Time"
        
        timePicker.dataSource = self
        timePicker.delegate = self
        view.addSubview(timePicker)
        timePicker.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
        timePicker.selectRow(NSDate().hour - 1, inComponent: 1, animated: false)
        
        // Configure tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FlightTableViewCell.self, forCellReuseIdentifier: FlightTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: timePicker, withOffset: 0)
        
        fetchedResultsController.delegate = self
        
        beginFetch()
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 7 // Days
        case 1:
            return 24 // Hours
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            switch row {
            case 0:
                return "Today"
            case 1:
                return "Tomorrow"
            default:
                let now = NSDate()
                let date = NSDate.date(year: now.year, month: now.month, day: now.day + row)
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEEE"
                return formatter.stringFromDate(date)
            }
        case 1:
            return "\( (row % 12) + 1 ) :00 \( row >= 11 && row != 23 ? "PM" : "AM" )"
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 150.0
        case 1:
            return 150.0
        default:
            return 0.0
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        beginFetch()
    }
    
    internal func beginFetch() -> Void {
        if flightsRequest != nil {
            flightsRequest?.cancel()
            flightsRequest = nil
        }
        
        CoreManager.sharedManager.resetFlights()
        
        let now = NSDate()
        let day = timePicker.selectedRowInComponent(0)
        let hour = timePicker.selectedRowInComponent(1) + 1
        let date = NSDate.date(year: now.year, month: now.month, day: now.day + day, hour: hour, minute: 0, second: 0)
        flightsRequest = CoreManager.sharedManager.fetchDepartures(airportCode!, departureDate: date)
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (fetchedResultsController.sections?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultsController.fetchedObjects?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - UITableViewDatasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FlightTableViewCell.identifier, forIndexPath: indexPath) as! FlightTableViewCell
        if let flight = fetchedResultsController.fetchedObjects![indexPath.item] as? Flight {
            configureCell(cell, flight: flight)
        }
        return cell
    }
    
    func configureCell(cell: FlightTableViewCell, flight: Flight) -> Void {
        
        let departure = "🛫 \(flight.departureDate!.stringFromFormat("hh:mm"))"
        let arrival = "\(flight.arrivalDate!.stringFromFormat("hh:mm")) 🛬 \(flight.arrivalAirportCode!)"
        let airline = Airline.MR_findFirstByAttribute("airlineCode", withValue: flight.carrierCode!)
        
        cell.textLabel?.text = departure + " ✈︎ " + arrival
        cell.detailTextLabel?.text = "\(airline!.name!) #\(flight.flightNumber!)"
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
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
            if let cell = tableView.cellForRowAtIndexPath(indexPath!)! as? FlightTableViewCell {
                if let flight = fetchedResultsController.fetchedObjects![indexPath!.item] as? Flight {
                    configureCell(cell, flight: flight)
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

    
}