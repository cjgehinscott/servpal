//
//  SearchVM.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/10/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SearchVM: NSObject, ServpalViewModel {
    
    var view: SearchViewController?

    func setupWith(_ view: UIViewController?) {
        self.view = view as? SearchViewController
    }
    
    func isViewAttached() -> Bool {
        return view != nil
    }
}
