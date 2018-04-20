//
//  CoreDataManager.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 5/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import CoreData
import UIKit
typealias notebookCompletion = (Notebook,NSManagedObjectContext)->()
struct CoreDataManager{
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Everpobre")
        container.loadPersistentStores{ (storeDescription, err) in
            if let err = err{
                fatalError("Failed loading data @persistent cointainer: \(err)")
            }
        }
        return container
    }()

    func fetchNotes()->[Note]{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do{
            let notes = try context.fetch(fetchRequest)
            return notes
        }catch let loadErr{
            print("Failed loading notes: ",loadErr)
            return []
        }
    }
    func fetchDefaultNoteBook()->Notebook?{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Notebook>(entityName: coreDataNames.Notebook.rawValue)
        fetchRequest.predicate = NSPredicate(format: "is_default == true")
        
        do {
            let notebook = try context.fetch(fetchRequest)
            if(notebook.count > 0){
                return notebook.first
            }
            
            let view = UIViewController()
            view.showError(title: "The isn't any default notebook. Please select one")
        } catch let fetchErr {
            print("Failed fetching default notebook:", fetchErr)
           
        }
        
         return nil
    }
    func createNotebook(name:String,isOn:Bool)->(Notebook?,String?){
        
        var notebook = fetchNotebook(predicate: NSPredicate(format: "name == %@", name), completion: nil)
        
        if(notebook != nil){
            return (nil,"Already exists a notebook with this name")
        }
        
        if isOn{
             notebook = fetchNotebook(predicate: NSPredicate(format: "is_default == true"), completion: {
                (notebook,context) in
                notebook.is_default = false
                do{
                    try context.save()
                }catch let saveErr{
                    print("Error saving notebook",saveErr)
                }
                
            })
           
        }

        
        let context = persistentContainer.viewContext
        
        let newNotebook = Notebook(context: context)
        newNotebook.name = name
        newNotebook.is_default = isOn

        do {
            try context.save()
            return (newNotebook,nil)
        } catch let error {
            print("Error create notebook: ",error)
                return (nil,nil)

        }
    
    }
    func createNote(title:String,date:Date,notebook:Notebook,text:String,images:[UIImageView]?,latitude:Double?,longitude:Double?)->(Note?,Error?){
        
        let context = persistentContainer.viewContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        note.title = title
        note.date = date
        note.text = text
         note.notebook = notebook
        //            note.latitude = (latitude ?? nil)!
        //            note.longitude = (longitude ?? nil)!
       
        
   
        
        //            DispatchQueue.main.async {
        //                do {
        //                    try context.save()
        //                    return(note,nil)
        //                } catch let savErr {
        //                    return(nil,savErr)
        //                }
        //            }

        do {
            try context.save()
            return(note,nil)
        } catch let savErr {
            return(nil,savErr)
        }
   
        

       
    }
    
    func fetchNotebooks()->[Notebook]{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Notebook>(entityName: coreDataNames.Notebook.rawValue)

        do{
            let notebooks = try context.fetch(fetchRequest)
            return notebooks

        }catch let fetchErr{
            print("Failed loading notebook data:\(fetchErr)")
            return []
        }

    }
    
    
    private func fetchNotebook(predicate:NSPredicate,completion:notebookCompletion?) -> Notebook?{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Notebook>(entityName: coreDataNames.Notebook.rawValue)
        fetchRequest.predicate = predicate
        
        do {
            let notebook = try context.fetch(fetchRequest) as [Notebook]
            //check if a notebook exists
            if(notebook.count > 0){
                
                if completion != nil{
                    notebook.forEach({completion!($0,context)})
                    
                }
                 guard let notebook = notebook.first else {return nil}
                    return notebook
                
            }else{
           
                return nil
            }
        } catch let fetchErr {
             print("Error fetching notebook at creation ",fetchErr)
            return nil
        }
    }
    
    
    func changeNotesAndDeleteNotebook(notebookOrigin:Notebook,notebookDestination:Notebook)->Error?{
     
    
        notebookOrigin.note?.forEach{
            ($0 as! Note).notebook = notebookDestination
   
        }
        
        let context = persistentContainer.viewContext
        do{
            try context.save()
        }catch let err{
            return err
        }
        
    
        
        return nil
        
    }
    
    
    
}
