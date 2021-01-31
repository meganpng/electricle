//
//  MapController.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//
import CoreData
import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var getLocationListing:DisplayListing = DisplayListing(Title: "", Content: "", Image: UIImage(), Location: "", UserName: "", Email: "", PhoneNo: "", Id: "")
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager:CLLocationManager = CLLocationManager()
    let userController:UserController = UserController()
    let listingController:ListingController = ListingController()
    
    
    var locationString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        centreMapOnLocation(locationString: getLocationListing.Location)
    }
    
    let regionRadius:CLLocationDistance = 250
    
    func centreMapOnLocation(locationString: String){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationString, completionHandler: {p,e in
            let location = p![0].location!
            let lat = String(format: "Lat: %3.12f", location.coordinate.latitude)
            let long = String(format: "Long: %3.12f", location.coordinate.longitude)
            let maplocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = maplocation.coordinate
            annotation.title = self.getLocationListing.Location
            self.mapView.addAnnotation(annotation)
            print("\(lat), \(long)")
            
            self.mapView.setRegion(MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius), animated: true)
        })
        
        
    }
}
