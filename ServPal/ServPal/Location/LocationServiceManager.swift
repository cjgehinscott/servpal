//
//  LocationServiceManager.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/2/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate {
    func trackingLocation(currentLocation: CLLocation)
    func trackingLocationDidFailWithError(error: NSError)
}

class LocationServiceManager: NSObject, CLLocationManagerDelegate {
    
    class var sharedInstance: LocationServiceManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            
            static var instance: LocationService? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = LocationService()
        }
        return Static.instance!
    }
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        // singleton for get last(current) location
        self.currentLocation = location
        
        // use for real time update location
        updateLocation(location)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        // do on error
        updateLocationDidFailWithError(error)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.trackingLocation(currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.trackingLocationDidFailWithError(error)
    }
}
