//
//  ModalNotebookViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 7/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit

protocol ModalNotebookViewControllerDelegate{
    
    func didNotebookSelect(notebook:Notebook)
    func didNotebookUpdate(notebook:Notebook,numOfNewNotes:Int)
    func didNotebookDelete(notebook:Notebook)

}


 final class ModalNotebookViewController: UIViewController {
    var delegate: ModalNotebookViewControllerDelegate!
    var forCreateNewNote: Bool = false
    
    
    var notebooks:[Notebook]! = nil
    let textLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let notebookTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: - inits
    
    init(delegate:ModalNotebookViewControllerDelegate,titleText:String,forCreateNewNote:Bool){
        self.delegate = delegate
        self.textLabel.text = titleText
        self.forCreateNewNote = forCreateNewNote

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI(){
        
        view.addSubview(textLabel)
        if #available(iOS 11, *) {
            textLabel.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        } else {
            textLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        }
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        textLabel.text = "Select note's notebook"
       
        view.backgroundColor = .white
        
        view.addSubview(notebookTable)
        notebookTable.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
        notebookTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        notebookTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        notebookTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        notebookTable.dataSource = self
        notebookTable.delegate = self
//        notebookTable.backgroundColor = .red
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(cancelHandler))
        
        
        
    }
    
    
    
    //MARK: - handlers
    
    @objc private func cancelHandler(){
        dismiss(animated: true, completion: nil)
    }
    
    

}
