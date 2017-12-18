//
//  UserBody.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import ObjectMapper

class UserBody: Mappable {
    var user: User?
    var profile: Profile?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        profile <- map["profile"]
    }
    
    
}
