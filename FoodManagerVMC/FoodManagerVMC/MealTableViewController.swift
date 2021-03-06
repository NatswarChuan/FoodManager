//
//  MealTableViewController.swift
//  FoodManagerVMC
//
//  Created by Vu Minh Chuan on 5/8/21.
//

import UIKit

class MealTableViewController: UITableViewController {
    enum NavType {
        case addMeal;
        case editMeal;
    }
    
    let dao = Database();
    var navType:NavType = .addMeal;
    var mealData:[Meal] = [Meal]();
    var mealCellData:Meal?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let meal = Meal(mealName: "a", mealImg: UIImage(named: "defaultImage"), mealRating: 4){
            mealData += [meal];
        }
        
        navigationItem.leftBarButtonItem = editButtonItem;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "mealTableViewCell";
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? MealTableViewCell {
            let meal = mealData[indexPath.row];
            cell.mealName.text = meal.mealName;
            cell.mealImg.image = meal.mealImg;
            cell.mealRatingControl.rating = meal.mealRating;
            return cell;
        }
        else{
            fatalError("can't create cell");
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mealData.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    @IBAction func unwindFromMealDetailToMealTableView(sender:UIStoryboardSegue){
        //as? ep kieu nguoc
        
        if navType == .addMeal {
            
            if let srcController = sender.source as? MealDetailController,let meal = srcController.meal{
                
                let newIndexPath = IndexPath(row: mealData.count, section: 0);
                
                mealData += [meal];
                
                tableView.insertRows(at: [newIndexPath], with: .automatic);
                
                dao.createMeal(meal);
            }
        }
        else{
            if let srcController = sender.source as? MealDetailController, let meal = srcController.meal,let indexCell = tableView.indexPathForSelectedRow{
                let row = indexCell.row;
                mealData[row] = meal;
                tableView.reloadRows(at: [indexCell], with: .automatic);
            }
        }
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let segueName = segue.identifier{
            if(segueName == "addMeal"){
                navType = .addMeal;
            }else{
                navType = .editMeal;
                
                if let cellSelected = sender as? MealTableViewCell ,let indexCell = tableView.indexPathForSelectedRow ,let mealDetail = segue.destination as? MealDetailController{
                    
                    mealDetail.meal = mealData[indexCell.row];
                    mealDetail.navType = .editMeal;
                    
                }
            }
        }else{
            print("...!!!BUG!!!...");
        };
    }
}
