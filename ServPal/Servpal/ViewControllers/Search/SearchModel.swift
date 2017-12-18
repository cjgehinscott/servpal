//
//  SearchModel.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/10/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import Realm

class SearchModel: NSObject, ServpalModel {

    var viewModel: SearchVM?
    
    func setupWith(_ viewModel: ServpalViewModel?) {
        self.viewModel = viewModel as? SearchVM
    }
}
