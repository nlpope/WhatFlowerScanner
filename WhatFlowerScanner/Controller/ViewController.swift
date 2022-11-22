//
//  ViewController.swift
//  WhatFlowerScanner
//
//  Created by Noah Pope on 10/27/22.
//

import UIKit
import Vision
import CoreML
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var flowerManager = FlowerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    // MARK: DELEGATE METHODS
    
    //DELEGATE METHODS ARE TRIGGERED AUTOMATICALLY AS CHANGES ARE DETECTED, NO CALL NEEDED
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let convertedCIIMAGE = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage to CIImage")
            }
            
            imageView.image = userPickedImage
            
            detect(flowerImage: convertedCIIMAGE)

        }
        
        imagePicker.dismiss(animated: true)

    }
    
    // CIImage = A representation of an image to be processed by Core Image filters.
    func detect(flowerImage: CIImage) {

        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to load results from request")
            }
            
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier.capitalized
            } else {
                print("no results were loaded")
            }
        }
        
        
            
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try? handler.perform([request])
        }
        catch {
            print(error)
        }
    }
        


    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}





/**
 Notes:
 Goal: Get a hold of and display the "extract" prop in the resulting app image display text 
 ->format an http request usihg alamofire passing it parameters and the url and print entire json into debug area
 */

/**UNUSED/VALUEABLE CODE**/

//    func detect(image: CIImage) {
//        //(CoreImageImage) THIS FUNC PROCESSES THE IMAGE USING CORE IMAGE FILTERS
//        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
//            fatalError("Loading CoreML Model Failed.")
//        }
//
//        let request = VNCoreMLRequest(model: model) { request, error in
//            guard let results = request.results as? [VNClassificationObservation] else {
//                fatalError("model failed to process image error: \(String(describing: error))")
//            }
//
//            if let firstResult = results.first {
//                print (firstResult.identifier)
//            }
//
//        }
//    }


//if let firstResult = results.first {
//    if firstResult.identifier.contains("hotdog") {
//        self.navigationItem.title = "Hotdog!"
//    } else {
//        self.navigationItem.title = "Not Hotdog!"
//    }
//} else {
//    print("no results were loaded")
//}
