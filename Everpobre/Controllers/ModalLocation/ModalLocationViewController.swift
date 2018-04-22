//
//  ModalLocationViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 22/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol ModalLocationViewControllerDelegate {
    func didUploadAddress(address:String)

}
class ModalLocationViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var delegate: ModalLocationViewControllerDelegate!
    
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCoreLocation()
    }
    
    //MARK: - setup
  
  
    
    private func setupCoreLocation(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
   }
    
    
    private func setupNavBar(){
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelHanlder))
        navigationItem.leftBarButtonItem = cancelButton
        
        
        let savePosition = UIBarButtonItem(title: "Save location", style: .done, target: self, action: #selector(saveLocationHandler))
        navigationItem.rightBarButtonItem = savePosition
    }
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        self.mapView.setRegion(region, animated: true)
//       self.mapView.setCenter((locationManager.location?.coordinate)!, animated: true)
    }
    
  
    
    
    //MARK: - handlers
    @objc private func saveLocationHandler(){
   
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(locationManager.location!) { (placemarks, error) in
            
            
            
            let addressToSent = ("\((placemarks![0].addressDictionary!["Street"])!), \((placemarks![0].addressDictionary!["State"])!)")
            self.delegate.didUploadAddress(address: addressToSent)
        }
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    @objc private func cancelHanlder(){
        dismiss(animated: true, completion: nil)
    }
    
 
    
    

    

}
