//
//  ViewController.swift
//  Wilos
//
//  Created by Umair Sharif on 7/22/17.
//  Copyright © 2017 usharif. All rights reserved.
//

import UIKit
import SwiftSky
import CoreLocation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = keys {
            let clientSecret = dict["darkSkySecret"] as? String
            SwiftSky.secret = clientSecret
        }
        
        let locationManager = CLLocationManager()
        var currentLocation = CLLocation()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            currentLocation = locationManager.location!
        }
        
        SwiftSky.get([.current, .minutes, .hours, .days, .alerts],
                     at: Location(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude),
                     {result in
                        switch result {
                        case .success(let forecast):
                            print(forecast)
                        case .failure(let error):
                            print(error)
                        }
        })
    }
    
}

