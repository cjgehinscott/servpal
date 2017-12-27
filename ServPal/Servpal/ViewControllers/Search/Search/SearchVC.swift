//
//  SearchVC.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/23/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchVC: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    
    var viewModel: SearchVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        searchTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        searchTF.text = viewModel?.getSearchTerm()
    }
    
    func setup(_ searchTerm:String?){
        viewModel = SearchVM(self)
        viewModel?.setSearchTerm(searchTerm)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setLoading(_ isLoading:Bool){
        SVProgressHUD.setForegroundColor(UIColor.primary)
        if isLoading {
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }

}
