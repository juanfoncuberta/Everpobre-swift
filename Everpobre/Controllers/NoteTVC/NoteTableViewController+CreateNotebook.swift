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
        
        notebooks.append(notebook)
        let section = notebooks.count
        tableView.insertSections(IndexSet.init(integer: section-1), with: .automatic)
    
    }
    
    
}
