//
//  NoteTableViewController+CreateNotebook.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 5/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit

extension NoteTableViewController: CreateNotebookViewControllerDelegate{
    func addNotebook(notebook: Notebook) {
        
        tableView.reloadData()
    
    }
    
    
}
