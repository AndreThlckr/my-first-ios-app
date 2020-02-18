//
//  BarViewController.swift
//  De Bar em Bar
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log
import MapKit

class BarViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var barNameTextField: UITextField!
    @IBOutlet weak var barAddressTextField: UITextField!
    @IBOutlet weak var barPhoneTextField: UITextField!
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var barRatingBar: RatingBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    private var imagePicker: UIImagePickerController = UIImagePickerController()
    
    var bar: Bar?
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = barNameTextField.text ?? "Novo bar"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barNameTextField.delegate = self
        barPhoneTextField.delegate = self
        barAddressTextField.delegate = self
        
        if let bar = bar {
            navigationItem.title = "Edit bar"
            barNameTextField.text = bar.name
            barAddressTextField.text = bar.address
            barPhoneTextField.text = bar.phone
            barImageView.image = bar.photo
            barRatingBar.rating = bar.rating
            latitudeTextField.text = String(bar.coordinate.latitude)
            longitudeTextField.text = String(bar.coordinate.longitude)
        }
        
        updateSaveButtonState()
    }
    
    @IBAction func onBarImageViewClick(_ sender: UITapGestureRecognizer) {
        print("Clicou")
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Deu errado, mermão")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage {
            barImageView.contentMode = .scaleAspectFill
            barImageView.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddBarMode = presentingViewController is UINavigationController
        if isPresentingInAddBarMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController  = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The BarViewController isn't inside a navigation controller.")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let identifier = segue.identifier ?? ""
        
        if(identifier == "SelectLocation") {
            os_log("Selecting location.", log:OSLog.default, type: .debug)
            
            guard let mapViewController = segue.destination as? MapViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            mapViewController.barRequestingCoordinates = bar
            
            
        } else {
            
            guard let button = sender as? UIBarButtonItem, button === saveButton else {
                os_log("O saveButton não foi pressionado; cancelando...", log: OSLog.default, type: .debug)
                return
            }
            
            let name = barNameTextField.text ?? ""
            let address = barAddressTextField.text ?? ""
            let phone = barPhoneTextField.text ?? ""
            let photo = barImageView.image
            let rating = barRatingBar.rating
            let stringLatitude = latitudeTextField.text ?? "0"
            let stringLongitude = longitudeTextField.text ?? "0"
            
            let latitude = Double(stringLatitude) ?? 0
            let longitude = Double(stringLongitude) ?? 0
            
            bar = Bar(name: name, address: address, phone: phone, photo: photo, rating: rating, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        //Disable the save button if the text field is empty
        
        let text = barNameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
    }
}
