//
//  LoginResponse.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginResponse:Mappable {
    
    var userBody: UserBody?
    var phpSessionId: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userBody <- map["user"]
    }
}
