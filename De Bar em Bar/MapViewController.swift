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
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set initial location in Proway
        let initialLocation = CLLocation(latitude: -26.9172369, longitude: -49.0707435)
        
        centerMapOnLocation(location: initialLocation)
        
        loadSampleBares()
    }
    
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func loadSampleBares(){
        let photo1 = UIImage(named: "bar1")
        let photo2 = UIImage(named: "bar2")
        let photo3 = UIImage(named: "bar3")
        
        guard let bar1 = Bar(name: "Barzinho da esquina", address: "Blumenau", phone: "3382 9038", photo: photo1, rating: 3, coordinate: CLLocationCoordinate2D(latitude: -26.9168374, longitude: -49.0712756)) else {
            fatalError("Unable to instantiate bar1")
        }
        
        guard let bar2 = Bar(name: "Bar top", address: "Timbó", phone: "3382 9038", photo: photo2, rating: 4, coordinate: CLLocationCoordinate2D(latitude: -26.917876, longitude: -49.0709269)) else {
            fatalError("Unable to instantiate bar2")
        }
        
        guard let bar3 = Bar(name: "TÁ CHOVENDO HAMBURGUER", address: "Londres", phone: "3382 9038", photo: photo3, rating: 1, coordinate: CLLocationCoordinate2D(latitude: -26.9164362, longitude: -49.0718351)) else {
            fatalError("Unable to instantiate bar3")
        }
        
        mapView.addAnnotation(bar1)
        mapView.addAnnotation(bar2)
        mapView.addAnnotation(bar3)
    }
    
}
