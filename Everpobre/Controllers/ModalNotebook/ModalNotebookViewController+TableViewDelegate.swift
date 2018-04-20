//
//  ModalNoteViewController+TableViewDelegate.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 7/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit


protocol ModalNoteViewControllerDelegate {
    func hola(notebook:Notebook)
}

extension ModalNotebookViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return notebooks.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "notebookModal"
        
        // Descubrir la persona que tenemos que mostrar
        let notebook = notebooks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.textColor = .black
        
        // Sicronizar celda y persona
        cell.textLabel?.text = notebook.name
        
        if notebook.is_default{
            cell.detailTextLabel?.text = "Default"
        }
        
        // Devolver la celda
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if !forCreateNewNote{
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteNotebookHandler)
            deleteAction.backgroundColor = .red
            
            
            let editAction = UITableViewRowAction(style: .normal, title: "Select as default", handler: selectAsDefaultHandler)
            editAction.backgroundColor = UIColor.gray
            
            return [deleteAction,editAction]
        }
        return []
        
    }
    
    //MARK: - handlers tableviewdelegate
    private func deleteNotebookHandler(action:UITableViewRowAction,indexPath: IndexPath){
        
           let deleteOptions = UIAlertController(title: "Select action", message: "What you want to do with the notes?", preferredStyle: .actionSheet)
        
        let notebooksListAction = UIAlertAction(title:"Delete", style: .default){
            
            (_) in
         
            
            
        }
       
        let changeNotebookListAction = UIAlertAction(title: "Transfer to another notebook", style: .default) {
            (_) in
            let notebook = self.notebooks[indexPath.row]
            self.changeNotesFromNotebookHanlder(notebook: notebook)
        }
        
        
     
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        deleteOptions.addAction(notebooksListAction)
        deleteOptions.addAction(changeNotebookListAction)
        deleteOptions.addAction(cancelAction)
    
        present(deleteOptions,animated: true,completion: nil)
    }
    
    //TODO
    private func selectAsDefaultHandler(action:UITableViewRowAction,indexPath: IndexPath){
        
    }
    
    private func changeNotesFromNotebookHanlder(notebook notebookOrigin: Notebook){
        let selectNotebookDestinationAlert = UIAlertController(title: "Select the destionation", message: nil, preferredStyle: .actionSheet)
        
        notebooks.forEach{
            if($0.name != notebookOrigin.name){
                let notebook = $0
                let alertAction = UIAlertAction(title: $0.name, style: .default){ (UIAlertAction) in
                    
                   let err = CoreDataManager.shared.changeNotesAndDeleteNotebook(notebookOrigin: notebookOrigin, notebookDestination: notebook)
                }
                selectNotebookDestinationAlert.addAction(alertAction)
            }
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        selectNotebookDestinationAlert.addAction(cancelAlert)
        present(selectNotebookDestinationAlert, animated: true)
    }
    
    
}


extension ModalNotebookViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if forCreateNewNote {
            let notebook = notebooks[indexPath.row]
            self.delegate.didNotebookSelect(notebook:notebook)
            dismiss(animated: true, completion: nil)
        }
      
  
    }
}
