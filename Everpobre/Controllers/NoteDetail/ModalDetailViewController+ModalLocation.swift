//
//  ModalDetailViewController+ModalLocation.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 22/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation

extension NoteDetailViewController: ModalLocationViewControllerDelegate{
    func didUploadAddress(address: String) {
        self.addressLabel.text = address
        print("address label \(self.addressLabel.text)")
    }
    
    
}
