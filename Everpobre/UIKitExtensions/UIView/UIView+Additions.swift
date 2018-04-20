//
//  UIView+Additions.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 2/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit


extension UIView{
    
    func addCornerAndBorder(color:UIColor){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
    
    
 
    

    
    
    

    
   
}
