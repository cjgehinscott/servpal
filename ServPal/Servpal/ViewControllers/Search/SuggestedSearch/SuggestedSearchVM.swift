//
//  SuggestedSearchVM.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/10/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SuggestedSearchVM: NSObject, ServpalViewModel {
    
    required convenience init?(_ view: UIViewController?) {
        self.init()
        self.view = view as? SuggestedSearchViewController
        model = SuggestedSearchModel()
    }
    
    
    var view: SuggestedSearchViewController?
    var model: SuggestedSearchModel?
    
    func isViewAttached() -> Bool {
        return view != nil
    }
    
    func getSuggestedSearchTerms()->[String]{
        return model?.suggestedSearchTerms ?? [String]()
    }
}
