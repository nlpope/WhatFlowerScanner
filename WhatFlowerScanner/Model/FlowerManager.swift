//
//  FlowerManager.swift
//  WhatFlowerScanner
//
//  Created by Noah Pope on 11/17/22.
//

import Foundation

struct FlowerManager {
    let wikiURL: String! = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&indexpageids"
    
    func fetchFlower(flowerName: String) {
        let urlString = "\(wikiURL)&titles=\(flowerName)"
    }
}





//pageID = result["query"]["pageids"][0] = 1276123  (contains extract so now we can use it in...)

//result["query"]["pages"][pageID]["title"]
//result["query"]["pages"][pageID]["extract"]

