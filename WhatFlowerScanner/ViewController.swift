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
        imagePicker.allowsEditing = false
    }
    
    //camera and capture works wout this func. just converting to UIImage for detction use later
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userPickedImage = info[UIImagePickerController.InfoKey.originalImage]
        
        imageView.image = userPickedImage as? UIImage
        
        imagePicker.dismiss(animated: true)
    }
    


    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}








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
