//
//  SearchVM.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/23/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SearchVM: NSObject, ServpalViewModel {
    
    var view: SearchVC?
    var model: SearchModel?
    
    required init?(_ view: UIViewController?) {
        super.init()
        self.view = view as? SearchVC
        self.model = SearchModel(self)
    }
    
    func isViewAttached() -> Bool {
        return view != nil
    }
    
    func setSearchTerm(_ searchTerm: String?){
        model?.searchTerm = searchTerm
    }
    
    func getSearchTerm()->String?{
        return model?.searchTerm
    }
    
    func searchForProfessionals(){
        ServPalApiManager.findProfessionalsBy(model?.searchTerm) { [weak self](professionals, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                self?.model?.setProfessionals(professionals)
            }
        }
    }

}
