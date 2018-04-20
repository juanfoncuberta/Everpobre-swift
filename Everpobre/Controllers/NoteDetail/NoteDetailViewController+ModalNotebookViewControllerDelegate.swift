    //
//  NoteDetailViewController+ModalNotebookViewControllerDelegate.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 19/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation

    
    extension NoteDetailViewController: ModalNotebookViewControllerDelegate{
        func didNotebookSelect(notebook: Notebook) {
            self.notebook = notebook
        }
        
        
    }
