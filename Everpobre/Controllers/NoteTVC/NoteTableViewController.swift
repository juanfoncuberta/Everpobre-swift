//
//  NoteTableViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 5/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
class IdentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = UIEdgeInsetsInsetRect(rect, inset)
        super.drawText(in: customRect)
    }
}
class NoteTableViewController: UITableViewController {
    var notebooks = [Notebook]()
    var notes = [Note]()
    var modalNotebookVC: ModalNotebookViewController!
//    var noteDetailVC: NoteDetailViewController!
//    var noteDetailNVC: UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Everpobre"
        self.notes = CoreDataManager.shared.fetchNotes()
        setupNavItems()
        fetchNotebooks()
//        noteDetailVC = NoteDetailViewController()
//        noteDetailNVC = noteDetailVC.wrappedInNavigation()
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return notebooks.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IdentedLabel()
        label.text = notebooks[section].name
        return label
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (notebooks[section].note?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        let currentNotes =  Array(notebooks[indexPath.section].note!) as! [Note]
        cell.textLabel?.text = currentNotes[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailVC = NoteDetailViewController(notebook: notebooks[indexPath.section], delegate: self)
        let currentNotes =  Array(notebooks[indexPath.section].note!) as! [Note]
       noteDetailVC.note = currentNotes[indexPath.row]
        navigationController?.pushViewController(noteDetailVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    //MARK: - setupNav
    
    private func setupNavItems(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Notebooks", style: .plain, target: self, action:#selector(addNewNoteBookHandler))
        
        let newNote = UIBarButtonItem(title: "New note", style: .plain, target: self, action: #selector(addNewNoteHandler))
        
        
      
        navigationItem.rightBarButtonItem = newNote
    }
    
    //MARK: - Handlers

  
    
    @objc private func addNewNoteHandler(sender:AnyObject,forEvent event: UIEvent){
        guard let touch = event.allTouches?.first else { return }
        
        //SHORT TAP
        if touch.tapCount == 1 {
            guard let defaultNotebook = CoreDataManager.shared.fetchDefaultNoteBook() else {return}
            let noteDetailVC = NoteDetailViewController(notebook: defaultNotebook, delegate: self)
            navigationController?.pushViewController(noteDetailVC, animated: true)
            
            
         //LONG TAP
        } else if touch.tapCount == 0 {

            modalNotebookVC = ModalNotebookViewController(delegate: self, titleText: "Select the note's notebook",forCreateNewNote:true)
            modalNotebookVC.notebooks = CoreDataManager.shared.fetchNotebooks()
            modalNotebookVC.delegate = self
            
            
            present(modalNotebookVC.wrappedInNavigation(), animated: true, completion: nil)
        }
    }
    
    @objc private func addNewNoteBookHandler(){

        let notebookOptions = UIAlertController(title: "Select action", message: "Choose an action to do with the notebook", preferredStyle: .actionSheet)
        
        
        let addNotebookAction = UIAlertAction(title: "Add notebook", style: .default){
            (_) in
            let createNotebookVC = CreateNotebookViewController()
            createNotebookVC.delegate = self
            self.present(createNotebookVC.wrappedInNavigation(), animated: true, completion: nil)
        }
        let notebooksListAction = UIAlertAction(title:"Notebooks", style: .default){
            (_) in
//            guard let navigationController = self.navigationController else {return}
            
            
            self.modalNotebookVC = ModalNotebookViewController(delegate: self, titleText: "Swipe the notebook to perform actions",forCreateNewNote:false)
            self.modalNotebookVC.notebooks = CoreDataManager.shared.fetchNotebooks()
  
            self.present(self.modalNotebookVC.wrappedInNavigation(), animated: true, completion: nil)
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        notebookOptions.addAction(addNotebookAction)
        notebookOptions.addAction(notebooksListAction)
        notebookOptions.addAction(cancelAction)
        
        present(notebookOptions,animated: true,completion: nil)

    }
    
    //MARK: - data handlers
    private func fetchNotebooks(){
        
        
        notebooks = []

        notes.forEach{ (note) in

            if !notebooks.contains(note.notebook!) {
                notebooks.append(note.notebook!)
                
            }
        }
        
    }
    
    func numOfNotesFromNotebook(notebook: Notebook) -> Int{
        var numOfNotes = 0
        notes.forEach{
            if($0.notebook == notebook){
                numOfNotes += 1
            }
        }
        return numOfNotes
    }

}
