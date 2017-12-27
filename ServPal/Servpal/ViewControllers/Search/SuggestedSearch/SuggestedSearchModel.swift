//
//  SuggestedSearchModel.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/10/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import Realm

class SuggestedSearchModel: NSObject, ServpalModel {

    var viewModel: SuggestedSearchVM?
    var suggestedSearchTerms = [kHairStylist,kPhotographer,kMakeupArtist,kPersonalTrainer,kBarber,kTattooArtist,kWeddingPlanner,kManicurist]
    
    required convenience init?(_ viewModel: ServpalViewModel?) {
        self.init()
        self.viewModel = viewModel as? SuggestedSearchVM
    }
}
