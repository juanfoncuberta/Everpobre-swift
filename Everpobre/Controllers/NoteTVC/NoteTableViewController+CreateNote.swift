//
//  NoteTableViewController+CreateNote.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 7/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import Foundation

extension NoteTableViewController:NoteDetailViewControllerDelegate{
    func didAddNote(note: Note) {
       
        guard let section = notebooks.index(of: note.notebook!) else {return}
        let row = numOfNotesFromNotebook(notebook: note.notebook!)
        print(row)
        
        let indexPath = IndexPath(row: row, section: section)
        tableView.insertRows(at: [indexPath], with: .middle)
    }
    
    
}
