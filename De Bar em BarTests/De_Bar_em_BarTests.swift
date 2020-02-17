//
//  De_Bar_em_BarTests.swift
//  De Bar em BarTests
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest
import MapKit
@testable import De_Bar_em_Bar

class De_Bar_em_BarTests: XCTestCase {
    //MARK: Bar Class Tests
    
    // Confirm that the Bar initializer returns a Bar object when passed valid parameters.
    func testBarInitializationSucceeds() {
        // Zero rating
        let zeroRatingBar = Bar.init(name: "Zero", address: "endereco", phone: "6846", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNotNil(zeroRatingBar)
        
        // Highest positive rating
        let positiveRatingBar = Bar.init(name: "Positive", address: "endereco", phone: "6846", photo: nil, rating: 5, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNotNil(positiveRatingBar)
    }

    // Confirm that the Bar initialier returns nil when passed a negative rating or an empty name.
    func testBarInitializationFails() {
        // Negative rating
        let negativeRatingBar = Bar.init(name: "Negative", address: "AddressPlaceholder", phone: "123456789", photo: nil, rating: -1, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNil(negativeRatingBar)
        
        // Empty String fields
        let emptyNameBar = Bar.init(name: "", address: "AddressPlaceholder", phone: "123456789", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNil(emptyNameBar)
        
        let emptyAddressBar = Bar.init(name: "NamePlaceholder", address: "", phone: "12345678", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNil(emptyAddressBar)
        
        let emptyPhoneBar = Bar.init(name: "NamePlaceholder", address: "AddressPlaceholder", phone: "", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNil(emptyPhoneBar)
        
        // Rating exceeds maximum
        let largeRatingBar = Bar.init(name: "RatingTooLarge", address: "AddressPlaceholder", phone: "123456789", photo: nil, rating: 6,  coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        XCTAssertNil(largeRatingBar)
    }
}
