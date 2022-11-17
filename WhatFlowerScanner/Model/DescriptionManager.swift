//
//  DescriptionManager.swift
//  WhatFlowerScanner
//
//  Created by Noah Pope on 11/17/22.
//

import Foundation

struct descriptionManager {
    let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts",
        "exintro" : "",
        "explaintext" : "",
//        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        //1 = true
        
    ]
}
