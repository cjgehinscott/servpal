//
//  SearchModel.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/23/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SearchModel: NSObject, ServpalModel {
    
    var viewModel: SearchVM?
    var searchTerm: String?
    private var professionals: [Professional]?
    
    required init?(_ viewModel: ServpalViewModel?) {
        super.init()
        self.viewModel = viewModel as? SearchVM
    }
    
    func getProfessionals()->[Professional]{
        return professionals ?? [Professional]()
    }
    
    func setProfessionals(_ professionals:[Professional]?){
        self.professionals = professionals
    }
}
