//
//  FoodManagerVMCTests.swift
//  FoodManagerVMCTests
//
//  Created by Vu Minh Chuan on 4/16/21.
//

import XCTest
@testable import FoodManagerVMC

class FoodManagerVMCTests: XCTestCase {

    func testMealCreateSuccess(){
        let meal:Meal = Meal(mealName: "c", mealImg: UIImage(), mealRating: 5)!;
        XCTAssertNotNil(meal);
    }

    func testMealCreateFail(){
        let emptyMealName = Meal(mealName: "", mealImg: nil, mealRating: 5);
        XCTAssertNil(emptyMealName);
        let mealRatingMax = Meal(mealName: "a", mealImg: nil, mealRating: 6);
        XCTAssertNil(mealRatingMax);
        let mealRatingMin = Meal(mealName: "b", mealImg: nil, mealRating: -5);
        XCTAssertNil(mealRatingMin);
    }
}
