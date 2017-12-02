//
//  SPError.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 11/21/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import ObjectMapper

class SPError: Mappable {

    var error: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
    }
}
