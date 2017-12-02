//
//  RLMResults+Additions.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/11/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import Foundation
import Realm

extension RLMResults {
    
    @objc func toArray() -> [RLMObject] {
        
        var array = [RLMObject]()
        if self.count > 0 {
            for i in 0...self.count-1 {
                array.append(self.object(at: i) as! RLMObject)
            }
        }
        
        return array
    }
    
}
