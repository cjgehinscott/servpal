//
//  Professional.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/24/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Professional: SPRLMObject, Mappable {
    
    let id = RealmOptional<Int>()
    @objc dynamic var isActive: Bool = false
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var initials: String?
    @objc dynamic var profession: String?
    @objc dynamic var city: String?
    @objc dynamic var state: String?
    @objc dynamic var zip: String?
    @objc dynamic var country: String?
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    @objc dynamic var avatar: String?
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
    let userID = RealmOptional<Int>()
    let professionID = RealmOptional<Int>()
    @objc dynamic var business: String?
    let locationID = RealmOptional<Int>()
    let distance = RealmOptional<Int>()
    var services = List<String>()
    let reviewsCount = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var slug: SPRLMObject?
    @objc dynamic var location: String?
    let rating = RealmOptional<Int>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    func mapping(map: Map) {
        id.value <- map["id"]
        isActive <- map["isActive"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        initials <- map["initials"]
        profession <- map["profession"]
        city <- map["city"]
        state <- map["state"]
        zip <- map["zip"]
        country <- map["country"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        avatar <- map["avatar"]
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
        userID.value <- map["userID"]
        professionID.value <- map["professionID"]
        business <- map["business"]
        locationID.value <- map["locationID"]
        distance.value <- map["distance"]
        services <- map["services"]
        reviewsCount.value <- map["reviewsCount"]
        name <- map["name"]
        slug <- map["slug"]
        location <- map["location"]
        rating.value <- map["rating"]
    }
    
    
    
}
