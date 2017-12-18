//
//  BaseViewModel.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/10/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import Foundation
import UIKit

protocol ServpalViewModel{
    func setupWith(_ view: UIViewController?)
    func isViewAttached()->Bool
}
