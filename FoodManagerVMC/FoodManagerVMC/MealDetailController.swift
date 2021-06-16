//
//  ViewController.swift
//  FoodManagerVMC
//
//  Created by Vu Minh Chuan on 4/16/21.
//

import UIKit

class MealDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var edtMealName: UITextField!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var ratingControll: RatingControl!
    
    enum NavType {
        case addMeal;
        case editMeal;
    }
    
    var navType:NavType = .addMeal;
    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edtMealName.delegate = self;
        
        // Do any additional setup after loading the view.
        
        //hien thi data meal
        if let mealCellData = meal{
            edtMealName.text = mealCellData.mealName;
            imgView.image = mealCellData.mealImg;
            ratingControll.rating = mealCellData.mealRating;
            navigationItem.title = mealCellData.mealName;
        }
    }
    
    func textFieldShouldReturn(_ texField: UITextField) -> Bool {
        texField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let mealName = textField.text{
            //print("Meal name eat: \(mealName)");
            navigationItem.title = mealName;
            //navigationItem.titleView.
        }
    }
    
    @IBAction func ImageProcess(_ sender: UITapGestureRecognizer) {
        edtMealName.resignFirstResponder();
        let imgpick = UIImagePickerController();
        imgpick.sourceType = .photoLibrary;
        imgpick.delegate = self;
        present(imgpick, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imgView.image = selectImg;
            dismiss(animated: true, completion: nil);
        }
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        if(navType == .addMeal){
            dismiss(animated: true, completion: nil);
        }else{
            if let navController = navigationController{
                navController.popViewController(animated: true);
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let btn = sender as? UIBarButtonItem , btn === btnSave{
            let mealName = edtMealName.text ?? "";
            let mealImg = imgView.image;
            let mealRating = ratingControll.rating;
            meal = Meal(mealName: mealName, mealImg: mealImg, mealRating: mealRating);
        }
    }
}
