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
    let wikiURL: String! = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&indexpageids"
    
        
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
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image.")
            }
            
            self.navigationItem.title = classification.identifier.capitalized
            self.requestInfo(flowerName: classification.identifier)
            
        }
        
        //i dont get this part
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func requestInfo(flowerName: String) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
        ]
        
        //MAY NEED TO SCALE BACK ALAMOFIRE VERSION TO 4.4 (SEE FREEMIND AND UDEMY MODULE NOTES)
        //SCRATCH THAT, "R&D LABS W ROHANT" (FREEMIND>ALAMOFIRE) TESTED FOR ERROR INSTEAD.
        
        AF.request(wikiURL, method: .get, parameters: parameters).responseJSON
        { response in
            if response.error == nil {
                print("Got the wikipedia info.")
                print(response)
            } else {
                fatalError("There was an error in AlamoFire's response: \(String(describing: response.error))")
            }
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
