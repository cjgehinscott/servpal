//
//  CategoryCVCell.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/22/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func setupWith(_ categoryName: String?){
        categoryNameLabel.text = categoryName
        switch categoryName {
        case kHairStylist?:
            backgroundImage.image = #imageLiteral(resourceName: "hairstylistBackground")
            break
        case kManicurist?:
            backgroundImage.image = #imageLiteral(resourceName: "manicureBackground")
            break
        case kWeddingPlanner?:
            backgroundImage.image = #imageLiteral(resourceName: "weddingPlannerBackground")
            break
        case kTattooArtist?:
            backgroundImage.image = #imageLiteral(resourceName: "tattooArtistBackground")
            break
        case kMakeupArtist?:
            backgroundImage.image = #imageLiteral(resourceName: "makeupArtistBackground")
            break
        case kPersonalTrainer?:
            backgroundImage.image = #imageLiteral(resourceName: "trainerBackgroundBackground")
            break
        case kPhotographer?:
            backgroundImage.image = #imageLiteral(resourceName: "photographerBackground")
            break
        case kBarber?:
            backgroundImage.image = #imageLiteral(resourceName: "barberBackground")
            break
        default:
            break
        }
    }
}
