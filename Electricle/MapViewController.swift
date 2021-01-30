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
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    let userController:UserController = UserController()
    let listingController:ListingController = ListingController()
    
    var location:String = ""
    @IBAction func showLocation(_ sender: Any) {
        print(locationManager.location!)
        centreMapOnLocation(location: locationManager.location!.coordinate)
        //mapView.showsUserLocation = true
            }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        centreMapOnLocation(location: locationManager.location!.coordinate)
    }
    
    let regionRadius:CLLocationDistance = 250
    
    func centreMapOnLocation(location: CLLocationCoordinate2D){
        let coordinateRegion = MKCoordinateRegion (center:location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        //mapView.showsUserLocation = true
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Me"
        self.mapView.addAnnotation(annotation)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler: {p,e in
            let lat = String(format: "Lat: %3.12f", p![0].location!.coordinate.latitude)
            let long = String(format: "Long: %3.12f", p![0].location!.coordinate.longitude)
            let nplocation = CLLocation(latitude: p![0].location!.coordinate.latitude, longitude: p![0].location!.coordinate.longitude)
            
            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = nplocation.coordinate
            annotation2.title = "Ngee Ann Polytechnic"
            annotation2.subtitle = "School Of ICT"
            self.mapView.addAnnotation(annotation2)
            print("\(lat), \(long)")
        })
        
        
    }
}
