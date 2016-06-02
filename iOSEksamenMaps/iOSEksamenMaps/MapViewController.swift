//
//  MapViewController.swift
//  iOSEksamenMaps
//
//  Created by Steffen on 30/05/16.
//  Copyright © 2016 Steffen. All rights reserved.
//

// import mapkit
import UIKit
import MapKit

// Add the delegates for both CLLocationManger & MKMapView
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManger = CLLocationManager()
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title in the navigation top bar
        self.title = "Map"
        
        // Assign the delegate of CLLocationManager & Map
        locationManger.delegate = self
        mapView.delegate = self
        
        // Set the accuracy that we want to use for tracking the user
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        // Ask the user for permission to track his/her location
        locationManger.requestWhenInUseAuthorization()
        
        // Now we need to rememeber to add a key to our info.plist.
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManager Delegate methods
    // This delegate method will be called once the authorization status changes, e.g. when the user accepts/disallow the use of his/her location
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse:
            print("User has accepted the use of his/her location")
            
            // Update the users location on the map
            locationManger.startUpdatingLocation()
            
            // Show the user location by a blue dot
            mapView.showsUserLocation = true
            
            // Try to get the coordinates for the users location
            if let userLocation = locationManger.location?.coordinate {
                let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                let lat = userLocation.latitude
                let long = userLocation.longitude
                
                let pin = MKPointAnnotation()
                pin.coordinate = CLLocationCoordinate2DMake(lat, long)
                pin.title = "test"
                
                mapView.addAnnotation(pin)
                
                mapView.setRegion(region, animated: true)
                
                // Update the labels of latitude & longitude
                self.latitudeLabel.text = String(lat)
                self.longitudeLabel.text = String(long)
            }
        default:
            break
        }
    }
    
    // This methods gets called once the startUpdatingLocation is running
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let lastLocation = locations.last
//        
//        let lat = lastLocation?.coordinate.latitude
//        let long = lastLocation?.coordinate.longitude
//        
//        self.latitudeLabel.text = String(lat)
//        self.longitudeLabel.text = String(long)
//    }
    
    // MARK: - MKMapView Delegate methods
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
    // update lat and long for the user
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let lat = (userLocation.location?.coordinate.latitude)!
        let long = (userLocation.location?.coordinate.longitude)!
        
        self.latitudeLabel.text = String(lat)
        self.longitudeLabel.text = String(long)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
