//
//  NoteDetailVC+Datepicker.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 22/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation


extension NoteDetailViewController: ModalDatePickerViewControllerDelegate{
    func dateDidChange(date: String) {
        self.dateLabel.text = date
    }
    
    
}
