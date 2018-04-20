//
//  UIViewController+Additions.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 1/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func wrappedInNavigation()->UINavigationController{
        return UINavigationController(rootViewController: self)
    }
    
    func showError(title:String){
 
        let alertController = UIAlertController(title: title,  message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func closeKeyboard(views: [UIView]){
        
        views.forEach{ (view) in
            if(view.isFirstResponder){
                view.resignFirstResponder()
            }
        }
    }

    
  
}
