//
//  MealTableViewCell.swift
//  FoodManagerVMC
//
//  Created by Vu Minh Chuan on 5/8/21.
//

import UIKit

@IBDesignable class MealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImg: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealRatingControl: RatingControl!
    //@IBOutlet weak var mealName: UILabel!
    //@IBOutlet weak var mealRatingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
