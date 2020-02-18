//
//  BarDataManager.swift
//  De Bar em Bar
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import Foundation
import UIKit
import os.log
import MapKit

class BarDataManager {
    
    static func loadSampleBares() -> [Bar] {
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
        
        return [bar1, bar2, bar3]
    }
    
    static func saveBares(bares: [Bar]){
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(bares, toFile: Bar.ArchiveURL.path)
        
        if isSucessfulSave {
            os_log("Bares salvos com sucesso.", log: OSLog.default, type: .debug)
        } else {
            os_log("Tentativa de salvar bares falhou...", log: OSLog.default, type: .error)
        }
    }
    
    static func loadBares() -> [Bar]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
}
