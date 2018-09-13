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


    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Everpobre"
        self.notebooks = CoreDataManager.shared.fetchNotebooks()
        if(self.notebooks.count == 0){
           let notebook =  CoreDataManager.shared.createNotebook(name: "My notebook", isOn: true)
            self.notebooks.append(notebook.0!)
        }
        setupNavItems()
        fetchNotes()

    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return notebooks.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IdentedLabel()
        label.text = notebooks[section].name
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (notebooks[section].note?.count) ?? 0
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
        let noteDetailVC = NoteDetailViewController(notebook: notebooks[indexPath.section], delegate: self,indexPath:indexPath)
        let currentNotes =  Array(notebooks[indexPath.section].note!) as! [Note]
       noteDetailVC.note = currentNotes[indexPath.row]
        navigationController?.pushViewController(noteDetailVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    

    //MARK: - setupNav
    private func setupNavItems(){
        navigationItem.leftBarButtonItem    =     UIBarButtonItem(title: "Notebooks", style: .plain, target: self, action:#selector(addNewNoteBookHandler))
        navigationItem.rightBarButtonItem   =     UIBarButtonItem(title: "New note", style: .plain, target: self, action: #selector(addNewNoteHandler))
        
    }
    
    
    //MARK: - Handlers
    @objc private func addNewNoteHandler(sender:AnyObject,forEvent event: UIEvent){
        guard let touch = event.allTouches?.first else { return }
        
        if(notebooks.count == 0){
             showError(title: "You haven't any notebook. Please create one before create a note")
            return
        }

        
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
    private func fetchNotes(){

        notes = []
        notebooks.forEach{
            $0.note?.forEach{
                notes.append($0 as! Note)
            }
        }
        
    }
    
    //TODO: Closure without return
    func numOfNotesFromNotebook(notebook: Notebook) -> Int{ return notes.filter{($0.notebook == notebook)}.count}
    

}
