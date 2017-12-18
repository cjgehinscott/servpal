//
//  SPUser.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/8/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import Realm
import ObjectMapper

class User: SPRLMObject, Mappable {

    @objc dynamic var id:Int = 0
    @objc dynamic var firstName:String?
    @objc dynamic var lastName: String?
    @objc dynamic var email: String?
    @objc dynamic var roleID: Int = 0
    @objc dynamic var isActive: Bool = true
    @objc dynamic var isExpired: Bool = false
    @objc dynamic var isLegacy: Bool = false
    @objc dynamic var isWizardComplete: Bool = false
    @objc dynamic var activatedAt: String?
    @objc dynamic var createdAt: Date?
    @objc dynamic var updatedAt: Date?
    @objc dynamic var name: String?
    @objc dynamic var role: String?
    @objc dynamic var profession: String?
    @objc dynamic var accountKey: String?
    @objc dynamic var customerKey: String?
    @objc dynamic var rating: Int = 0
    @objc dynamic var phpSessionId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        roleID <- map["roleID"]
        isActive <- map["isActive"]
        isExpired <- map["isExpired"]
        isLegacy <- map["isLegacy"]
        isWizardComplete <- map["isWizardComplete"]
        activatedAt <- map["activatedAt"]
        createdAt <- (map["createdAt"], DateFormatterTransform(dateFormatter: dateFormatter))
        updatedAt <- (map["updatedAt"], DateFormatterTransform(dateFormatter: dateFormatter))
        name <- map["name"]
        role <- map["role"]
        profession <- map["profession"]
        accountKey <- map["accountKey"]
        customerKey <- map["customerKey"]
        rating <- map["rating"]
    }
}
