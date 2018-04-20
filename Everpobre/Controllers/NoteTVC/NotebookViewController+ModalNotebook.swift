//
//  NotebookViewController+ModalNotebook.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 18/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation


extension NoteTableViewController: ModalNotebookViewControllerDelegate{
    func didNotebookSelect(notebook: Notebook) {
        
        let noteDetailVC = NoteDetailViewController(notebook: notebook, delegate: self)

        
        self.navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    
}
