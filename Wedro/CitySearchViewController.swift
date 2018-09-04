//
//  ViewController.swift
//  Wedro
//
//  Created by Jan Růžička on 01/09/2018.
//  Copyright © 2018 Jan Růžička. All rights reserved.
//

import UIKit
import MapKit


class CitySearchViewController: UIViewController {
    
    // MARK: Properties
    //
    let locateTableViewIdentifier = "LocateTableView"
    
    let locationManager = CLLocationManager()
    let nearbyCircularTolerance = 5.0
    
    var nearbyCities = [String]()
    var allCities = [City]()
    
    @IBOutlet weak var locateImageView: UIImageView!
    
    
    // MARK: Inherited Methods
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        locateImageView.isUserInteractionEnabled = true
        
        // TODO: Remove this test-initialisation
        //
        nearbyCities = ["Prague", "Beijing", "Los Angeles"]
        
        // JSON deserialization
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Custom Methods
    //
    @IBAction func switchToLocateTableView(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else {
            return
        }
        
        if gestureRecognizer.state == .ended {
            guard let controller = storyboard?.instantiateViewController(withIdentifier: locateTableViewIdentifier) as? LocateTableViewController else {
                fatalError("The view controller next in the segue initialised after using the 'Find by location' image button is not a LocateTableViewController!")
            }
            
            controller.citiesToShow = nearbyCities
                
            present(controller, animated: true, completion: nil)
        }
    }
    
    func loadCities() {
        //
    }
}

// Location Manager Delegate
//
extension CitySearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let coordinates = location.coordinate
            
            // TODO: Lookup the cities within the radius.
            
        } else {
            // No loaded coordinates
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

