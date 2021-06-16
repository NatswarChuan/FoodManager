//
//  Meal.swift
//  FoodManagerVMC
//
//  Created by Vu Minh Chuan on 5/8/21.
//

import UIKit
class Meal {
    var mealName:String
    var mealImg:UIImage?
    var mealRating:Int
    
    init() {
        self.mealName = "no name";
        self.mealImg = nil;
        self.mealRating = 0;
    }
    
    init?(mealName:String, mealImg:UIImage?, mealRating:Int) {
        if (mealName.isEmpty) {
            return nil;
        }
        if (mealRating > 5 || mealRating < 0) {
            return nil;
        }
        self.mealName = mealName;
        self.mealImg = mealImg;
        self.mealRating = mealRating;
    }
}
