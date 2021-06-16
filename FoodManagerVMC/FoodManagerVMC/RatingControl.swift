//
//  RatingControl.swift
//  FoodManagerVMC
//
//  Created by Vu Minh Chuan on 5/7/21.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    @IBInspectable var starNumber:Int = 5 {
        didSet {
            setUpRating();
        }
    };
    @IBInspectable var starSize:CGSize = CGSize(width: 50, height: 50){
        didSet{
            setUpRating();
        }
    };
    
    @IBInspectable var rating:Int = 2{
        didSet{
            updateRating();
        }
    };
    
    private var arrBtn:[UIButton] = [UIButton]();
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUpRating();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setUpRating();
    }
    
    private func setUpRating()->Void{
        let bundle = Bundle(for: type(of: self));
        
        let normal = UIImage(named: "normal",in: bundle,compatibleWith: .none);
        let selected = UIImage(named: "selected",in: bundle,compatibleWith: .none);
        let highlighted = UIImage(named: "highlighted",in: bundle,compatibleWith: .none);
       
        for btn in arrBtn {
            self.removeArrangedSubview(btn);
            btn.removeFromSuperview();
        }
        arrBtn.removeAll();
        for _ in 0..<starNumber{
        let btn = UIButton();
            btn.setImage(normal, for: .normal);
            btn.setImage(selected, for: .selected);
            btn.setImage(highlighted, for: .highlighted);
            
            btn.heightAnchor.constraint(equalToConstant: starSize.height).isActive = false;
            btn.widthAnchor.constraint(equalToConstant: starSize.width).isActive = false;
            
            btn.addTarget(self, action: #selector(actionTarget(btn:)), for: .touchUpInside);
            arrBtn.append(btn);
            self.addArrangedSubview(btn);
        }
        updateRating();
    }
    
    @objc private func actionTarget(btn:UIButton){
        if let pos = arrBtn.firstIndex(of: btn){
            if rating == pos+1 {
                rating -= 1
            }else{
                rating = pos + 1;
            }
        }
        updateRating();
    }
    
    private func updateRating(){
        for (i,btn) in arrBtn.enumerated() {
                btn.isSelected = i < rating;
        }
    }
}
