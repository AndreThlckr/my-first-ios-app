//
//  MapViewController.swift
//  De Bar em Bar
//
//  Created by André on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var bares = [Bar]()
    let regionRadius: CLLocationDistance = 1000
    
    //MARK: Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set initial location in Proway
        let initialLocation = CLLocation(latitude: -26.9172369, longitude: -49.0707435)
        
        centerMapOnLocation(location: initialLocation)
        
        if let savedBares = BarDataManager.loadBares() {
            bares += savedBares
        } else {
            bares += BarDataManager.loadSampleBares()
        }
        
        addAnnotations()
    }
    
    //MARK: Private Methods
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotations(){
        for bar in bares {
            mapView.addAnnotation(bar)
        }
    }
    
}
