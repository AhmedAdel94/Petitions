//
//  Petition.swift
//  Project7
//
//  Created by Ahmed Adel on 4/28/19.
//  Copyright © 2019 Ahmed Adel. All rights reserved.
//

import Foundation

struct Petition:Codable{
    var title:String
    var body:String
    var signatureCount:Int
}

// When you set data to conform to codable swift allows you to convert freely between JSON and that data



