//
//  MapViewController.swift
//  De Bar em Bar
//
//  Created by André on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
import os.log

class MapViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var bares = [Bar]()
    var barRequestingCoordinates: Bar?
    
    let regionRadius: CLLocationDistance = 1000
    
    //MARK: Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: -26.9172369, longitude: -49.0707435)
        
        centerMapOnLocation(location: initialLocation)
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
        if barRequestingCoordinates != nil {
            navigationItem.title = "Long press on location..."
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let savedBares = BarDataManager.loadBares() {
            if (bares != savedBares) {
                bares.removeAll(keepingCapacity: false)
                mapView.removeAnnotations(mapView.annotations)
            }
            bares += savedBares
        } else {
            bares += BarDataManager.loadSampleBares()
        }
        
        addAnnotations()
    }
    
    //MARK: Actions
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state != .began {
            return
        }
        guard barRequestingCoordinates != nil else {
            print("Deu merda")
            os_log("Long tap without requesting location", log:OSLog.default, type: .debug)
            return
        }
        
        print("Não deu merda")
        
        let locationInView = sender.location(in: mapView)
        
        let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        print("\(locationOnMap.latitude)  e  \(locationOnMap.longitude)")
        
        barRequestingCoordinates?.coordinate = locationOnMap
        
        performSegue(withIdentifier: "UnwindToBarViewController", sender: self)
        
        print("fim")
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
