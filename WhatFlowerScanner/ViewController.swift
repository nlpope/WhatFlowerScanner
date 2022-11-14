//
//  ViewController.swift
//  WhatFlowerScanner
//
//  Created by Noah Pope on 10/27/22.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
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
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage to CIImage")
            }
            
            imageView.image = userPickedImage
            
            detect(flowerImage: ciImage)

        }
        
        imagePicker.dismiss(animated: true)

    }
    
    // CIImage = A representation of an image to be processed by Core Image filters.
    func detect(flowerImage: CIImage) {
       //THE MODEL: VNCoreMLModel = container for our MLModel: inceptionV3
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model failed")
        }
        
        //THE ARRAY = RESULTS
        let request = VNCoreMLRequest(model: model) { request, error in
            //process result of request once completed
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to load results from request")
            }
            //so we have the array, but still no ref to image to classify
            
            print(results)
        }
            
        //create a handler that specifies the image we want to classify
        //THE IMAGE ANALYZER
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        //begin executing the request
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
 The detect func is so we can use inceptionV3 model to ID the flowers
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
