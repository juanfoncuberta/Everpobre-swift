//
//  NotebookViewController+ModalNotebook.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 18/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation


extension NoteTableViewController: ModalNotebookViewControllerDelegate{
    func didNotebookUpdate(notebook: Notebook, numOfNewNotes: Int) {
        
        if(numOfNewNotes > 0){
            guard let section = notebooks.index(of: notebook) else {return}
            let row = numOfNotesFromNotebook(notebook: notebook)
            var indexPathArray:[IndexPath] = []
            
            for noteRow in 0...numOfNewNotes - 1{
                indexPathArray.append(IndexPath(row: row + noteRow, section: section))
                
            }
            tableView.insertRows(at: indexPathArray, with: .middle)
        }
    }

    func didNotebookDelete(notebook: Notebook) {
        let section = notebooks.index(of: notebook)
        notebooks.remove(at: section!)
        tableView.deleteSections(IndexSet.init(integer: section!), with: .automatic)

    }

    
    func didNotebookSelect(notebook: Notebook) {
        let noteDetailVC = NoteDetailViewController(notebook: notebook, delegate: self)
        self.navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    
}
