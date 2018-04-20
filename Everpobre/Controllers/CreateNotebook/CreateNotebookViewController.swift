//
//  CreateNotebookViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 5/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
import CoreData

protocol CreateNotebookViewControllerDelegate{
    func addNotebook(notebook:Notebook)
}
class CreateNotebookViewController: UIViewController {

    var delegate: CreateNotebookViewControllerDelegate?
    let nameNotebookLabel:UILabel = {
        let label = UILabel()
        label.text = "Notebook name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameNotebookTextfield: UITextField = {
        let textfied = UITextField()
        textfied.placeholder = "Enter name"
        textfied.translatesAutoresizingMaskIntoConstraints = false
        return textfied
    }()
    
    let defaultNotebookLabel: UILabel = {
        let label = UILabel()
        label.text = "Default notebook"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let defaultNotebookSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.isOn = false
        return switcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        
    }


    //MARK: - UI
    private func setupUI(){
        
        view.backgroundColor = .white
        view.addSubview(nameNotebookLabel)
        
        if #available(iOS 11, *) {
            nameNotebookLabel.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        } else {
            
            nameNotebookLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        }
        nameNotebookLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameNotebookLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameNotebookLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameNotebookTextfield)
        
       
        nameNotebookTextfield.topAnchor.constraint(equalTo: nameNotebookLabel.topAnchor).isActive = true
        nameNotebookTextfield.leftAnchor.constraint(equalTo: nameNotebookLabel.rightAnchor).isActive = true
        nameNotebookTextfield.bottomAnchor.constraint(equalTo: nameNotebookLabel.bottomAnchor).isActive = true
        nameNotebookTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(defaultNotebookLabel)
        defaultNotebookLabel.topAnchor.constraint(equalTo: nameNotebookLabel.bottomAnchor, constant: 10).isActive = true
        defaultNotebookLabel.leftAnchor.constraint(equalTo: nameNotebookLabel.leftAnchor).isActive = true
        defaultNotebookLabel.widthAnchor.constraint(equalTo: nameNotebookLabel.widthAnchor).isActive = true
        defaultNotebookLabel.heightAnchor.constraint(equalTo: nameNotebookLabel.heightAnchor).isActive = true
        
        view.addSubview(defaultNotebookSwitch)
        defaultNotebookSwitch.topAnchor.constraint(equalTo: defaultNotebookLabel.topAnchor,constant: 10).isActive = true
        defaultNotebookSwitch.leftAnchor.constraint(equalTo: nameNotebookTextfield.leftAnchor).isActive = true
        defaultNotebookSwitch.bottomAnchor.constraint(equalTo: defaultNotebookLabel.bottomAnchor).isActive = true
        defaultNotebookSwitch.rightAnchor.constraint(equalTo: nameNotebookTextfield.rightAnchor).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNotebookHandler))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(cancelHandler))
    }
    
    //MARK: - Handlers
    
    @objc private func cancelHandler(){
        dismiss(animated: true, completion: nil)
    }
     @objc private func saveNotebookHandler(){
        
        guard let nameText = nameNotebookTextfield.text else {return}
        let tuple = CoreDataManager.shared.createNotebook(name: nameText, isOn: defaultNotebookSwitch.isOn)
        
        if let error = tuple.1{
           self.showError(title: error)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
}

