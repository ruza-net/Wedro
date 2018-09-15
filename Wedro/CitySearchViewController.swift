//
//  ViewController.swift
//  Wedro
//
//  Created by Jan Růžička on 01/09/2018.
//  Copyright © 2018 Jan Růžička. All rights reserved.
//

import UIKit
import MapKit
import CoreData


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
        loadCities()
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
                fatalError("[FATAL] The view controller next in the segue initialised after using the 'Find by location' image button is not a LocateTableViewController!")
            }
            
            controller.citiesToShow = nearbyCities
            
            print("[INFO] Presenting nearby city list.")
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    func loadCities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
        
//        if let count = try? context.count(for: request), count != 0 {
//            print("Yes!")
//
//        } else {
            if let dir = Bundle.main.path(forResource: "city.list", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: dir), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    
                    let entity = NSEntityDescription.entity(forEntityName: "CityEntity", in: context)
                    
                    if let cities = try? decoder.decode([City].self, from: data) {
                        for city in cities {
                            let cityRecord = NSManagedObject(entity: entity!, insertInto: context)

                            cityRecord.setValue(city.name, forKey: "name")
                            cityRecord.setValue(city.country, forKey: "country")
                            cityRecord.setValue(city.id, forKey: "id")
                            cityRecord.setValue(city.location["lat"], forKey: "latitude")
                            cityRecord.setValue(city.location["lon"], forKey: "longitude")
                        }

                        do {
                            try context.save()

                        } catch {
                            print("[ERROR] Couldn't save cities to Core Data model!")
                        }

                        allCities = cities

                    } else {
                        print("[ERROR] Can't initialize city list from data: \(data)")
                    }
                
                } catch {
                    fatalError("[FATAL] Can't load JSON city list!")
                }
            }
//        }
        
        print("[INFO] Successfully loaded \(allCities.count) cities.")
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
        print("[Error] Location manager failed with error: \(error)")
    }
}

