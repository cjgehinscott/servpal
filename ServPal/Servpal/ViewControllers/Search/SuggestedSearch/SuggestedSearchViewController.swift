//
//  SuggestedSearchViewController.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/2/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SuggestedSearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    var viewModel: SuggestedSearchVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        viewModel = SuggestedSearchVM(self)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation
    func goToSearchView(_ searchTerm:String?){
        if let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC{
            searchVC.setup(searchTerm)
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }

}

extension SuggestedSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getSuggestedSearchTerms().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCVCell", for: indexPath) as! CategoryCVCell
        cell.setupWith(viewModel?.getSuggestedSearchTerms()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchHeaderView", for: indexPath)
            
            return sectionHeader
        }else{
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToSearchView(viewModel?.getSuggestedSearchTerms()[indexPath.row])
    }
}

extension SuggestedSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goToSearchView(textField.text)
        return true
    }
}
