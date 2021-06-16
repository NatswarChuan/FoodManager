//
//  Database.swift
//  FoodManagerVMC
//
//  Created by Chuẩn Vũ Minh on 6/11/21.
//

import Foundation
import UIKit
import os.log

class Database {
    let DB_NAME = "meals.sqlite";
    let DB_PATH:String;
    let DB:FMDatabase?
    
    let TABLE_NAME = "meals";
    let ID = "id";
    let NAME = "name";
    let IMAGE = "image";
    let RATING = "rating";
    private var isCreate:Bool = false
    
    init(){
        let directories:[String] =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true);
        self.DB_PATH = directories[0]+"/"+self.DB_NAME;
        self.DB = FMDatabase(path: self.DB_PATH);
        
        if(DB != nil){
            os_log("Database is created!")
            
            isCreate = createTables();
        }else{
            os_log("Database is not created!")
        }
        
    }
    
    private func createTables() -> Bool{
        var result = false;
        if (open()){
            let sql = "CREATE TABLE " + TABLE_NAME + "("+ID+" INTEGER PRIMARY KEY AUTOINCREMENT, " + NAME+" TEXT," + IMAGE+" TEXT, " + RATING + " INTEGER)";
            if DB!.executeStatements(sql){
                os_log("Database table is created!")
                result = true;
            }else{
                os_log("Database table is not created!")
            }
        }
        
        close();
        return result;
    }
    
    private func open()->Bool{
        var result = false;
        
        if DB != nil && DB!.open() {
            
            os_log("Database is open!");
            
            result = true;
        }else{
            os_log("Can't opened database!");
        }

        return result;
    }
    
    private func close()->Void{
        if DB != nil {
            DB!.close();
        }
    }
    
    public func createMeal(_ meal:Meal){
        if(open()){
            let mealRating = meal.mealRating;
            let mealName = meal.mealName;
            var mealImageStr = "";
            
            if let mealImage = meal.mealImg{
                let dataImage:NSData = mealImage.pngData()! as NSData;
                mealImageStr = dataImage.base64EncodedString(options: .lineLength64Characters);
            }
            
            let sql = "INSERT INTO \(TABLE_NAME) (\(NAME), \(IMAGE), \(RATING)) VALUES (?, ?, ?)";
            
            if(DB!.executeUpdate(sql, withArgumentsIn: [mealName,mealImageStr,mealRating])){
                os_log("Insert success!");
            }else{
                os_log("Insert fail!");
            }
        }
        close();
    }
    
    public func getMeals(_ meals: inout [Meal]){
        if(open()){
            let sql = "SELECT * FROM \(TABLE_NAME)";
        }
        
        close();
    }
    
    public func deleteMealById(_ meal:Meal)->Bool{
        var result:Bool = false;
        
        if(open()){
            let sql = "";
        }
        
        close();
        return result;
    }
    
    public func updateMeal(_ oldMeal:Meal, _ newMeal:Meal)->Bool{
        var result:Bool = false;
        
        if(open()){
            let sql = "";
        }
        
        close();
        return result;
    }
}
