//
//  ViewController.swift
//  WhatFlowerScanner
//
//  Created by Noah Pope on 10/27/22.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage into CIImage")
            }
            // detect(image: ciimage)
        }
    }
    
//    func detect(image: CIImage) {
//        //(CoreImageImage) THIS FUNC PROCESSES THE IMAGE USING CORE IMAGE FILTERS
//        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
//            fatalError("Loading CoreML Model Failed.")
//        }
//
//        let request = VNCoreMLRequest(model: model) {
//
//        }
//    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

