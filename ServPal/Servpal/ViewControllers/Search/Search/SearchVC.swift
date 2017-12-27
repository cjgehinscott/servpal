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
    @IBOutlet weak var tableView: UITableView!
    
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVC") as! SearchTVC
        return cell
    }
}
