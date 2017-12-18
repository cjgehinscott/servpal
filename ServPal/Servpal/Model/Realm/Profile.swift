//
//  SPProfile.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/8/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import Realm
import ObjectMapper

class Profile: SPRLMObject, Mappable {

    @objc dynamic var id: Int = 0
    @objc dynamic var picture: String?
    @objc dynamic var cover: String?
    @objc dynamic var gender: String?
    @objc dynamic var mDescription: String?
    @objc dynamic var phone: String?
    @objc dynamic var mobile: String?
    @objc dynamic var website: String?
    @objc dynamic var facebook: String?
    @objc dynamic var twitter: String?
    @objc dynamic var instagram: String?
    @objc dynamic var linkedin: String?
    @objc dynamic var pinterest: String?
    @objc dynamic var google: String?
    @objc dynamic var youtube: String?
    @objc dynamic var userID: Int = 0
    @objc dynamic var professionID: Int = 0
    @objc dynamic var locationID: Int = 0
    @objc dynamic var timezoneID: Int = 0
    @objc dynamic var avatar: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        picture <- map["picture"]
        cover <- map["cover"]
        gender <- map["gender"]
        mDescription <- map["description"]
        phone <- map["phone"]
        mobile <- map["mobile"]
        website <- map["website"]
        facebook <- map["facebook"]
        twitter <- map["twitter"]
        instagram <- map["instagram"]
        linkedin <- map["linkedin"]
        pinterest <- map["pinterest"]
        google <- map["google"]
        youtube <- map["youtube"]
        userID <- map["userID"]
        professionID <- map["professionID"]
        locationID <- map["locationID"]
        timezoneID <- map["timezoneID"]
        avatar <- map["avatar"]
    }
}
