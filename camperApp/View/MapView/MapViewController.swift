//
//  ViewController.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import MapKit
import Anchorage
import SVProgressHUD

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var mapView = MKMapView(frame: UIScreen.main.bounds)
    var campers = [CamperDataModel]()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) { //hides the tab bar for this map view
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        let theToken = defaults.string(forKey: "idToken")
        print("isLoggedIn: \(isLoggedIn)")
        print("theToken: \(theToken)")
    }
    
    override func viewWillDisappear(_ animated: Bool) { //shows the nav bar when going to other tabs
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        trackUser()
        addAndConfigureViews()
        doLocationStuff()
        
        loadData()
        
        let gestureRecognizer = UILongPressGestureRecognizer()
        gestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        gestureRecognizer.addTarget(self, action: #selector(handleTap(gestureReconizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func deserializeData(loadedData: Data) {
        SVProgressHUD.show()
        APIManager().deserializeData(loadedData: loadedData) { (campers) in
            self.mapView.addAnnotations(campers)
            SVProgressHUD.dismiss()
        }
    }
    
    func loadData() {
        if let loadedData = APIManager().loadJsonFromUrl() {
            deserializeData(loadedData: loadedData)
        }
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    func setDelegates() {
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    func trackUser() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func addAndConfigureViews() {
        view.addSubview(mapView)
        mapView.heightAnchor == self.view.heightAnchor
        mapView.widthAnchor == self.view.widthAnchor
    }
    
    func doLocationStuff() {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(viewRegion, animated: false)
        }
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            
            locationManager.startUpdatingLocation()
        } else {
            print("Please turn on location services or else you ain't finding a place to go!")
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let data = view.annotation as? CamperDataModel {
            let editVC = EditVC()
            editVC.camper = data
            self.navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
     @objc func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        addLocationPopup(location: location)
    }
    
    func addLocationPopup(location: CGPoint){
        let title = "Hello Camper!"
        let message = "Please provide a name for this location you're trying to add."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter Campsite Name"
        })
        
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            guard let name = alert.textFields?[0].text else { return }
            SVProgressHUD.show()
            let coordinate = self.mapView.convert(location,toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
            APIManager().addData(name: name, lat: coordinate.latitude, long: coordinate.longitude, onCompletion: { (Bool) in
                self.loadData()
                SVProgressHUD.dismiss()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

