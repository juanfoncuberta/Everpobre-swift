//
//  NoteDetailVC+UI.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 1/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit

extension NoteDetailViewController{
    //MARK: - Properties
    
    
     func setupUI(){
        setUpNavigationItems()
        setUpMainBarItems()
        setUpTextLabel()
        setUpMap()
    }
    
    
    
    private func setUpMap(){
        
//        view.addSubview(mapView!)
//        mapView?.topAnchor.constraint(equalTo: mainTextView.bottomAnchor, constant: 10).isActive = true
//        mapView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//        mapView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
//        mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    private func setUpTextLabel(){
        
        view.addSubview(mainTextView)
        
        mainTextView.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: 5).isActive = true
        mainTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mainTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
//        mainTextView.addCornerAndBorder(color: .blue)
        
        view.addSubview(datePicker)
        showDatePicker(show: false, animateTime: 0)
    
    }
    
    private func setUpMainBarItems(){
     
        let mainUpStackView = UIStackView(arrangedSubviews: [titleTextField,notebookNameLabel])
        let mainDownStackView = UIStackView(arrangedSubviews: [dateLabel])
       let mainStackView = UIStackView(arrangedSubviews: [mainUpStackView,mainDownStackView])
        
        view.addSubview(stackViewContainer)
        
     
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
             stackViewContainer.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        } else {

            stackViewContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        }
        stackViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
//        stackViewContainer.addCornerAndBorder(color: .blue)
        stackViewContainer.backgroundColor = .white
        stackViewContainer.addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: stackViewContainer.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor, constant: -10).isActive = true
        
        mainUpStackView.axis = .horizontal
        mainUpStackView.translatesAutoresizingMaskIntoConstraints = false
        mainUpStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: stackViewContainer.rightAnchor,constant: -5).isActive = true
//         stackView.leftAnchor.constraint(equalTo: stackViewContainer.leftAnchor,constant: 5).isActive = true
        mainUpStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        mainUpStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        
        mainDownStackView.axis = .horizontal
        mainDownStackView.topAnchor.constraint(equalTo: mainUpStackView.bottomAnchor, constant: 5)
        mainDownStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
        
        titleTextField.textColor = .black
        titleTextField.leftAnchor.constraint(equalTo: mainUpStackView.leftAnchor, constant: 5).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleTextField.topAnchor.constraint(equalTo: mainUpStackView.topAnchor, constant: 5).isActive = true

        notebookNameLabel.textColor = .black
        notebookNameLabel.rightAnchor.constraint(equalTo: mainUpStackView.rightAnchor, constant: -10).isActive = true
        notebookNameLabel.topAnchor.constraint(equalTo: mainUpStackView.topAnchor, constant: 5).isActive = true
        
        let tapNotebookNameLabel = UITapGestureRecognizer(target: self, action: #selector(tapNotebookNameLabelHandler))
        notebookNameLabel.isUserInteractionEnabled = true
        notebookNameLabel.addGestureRecognizer(tapNotebookNameLabel)
        
//        dateLabel.textColor = .black
        dateLabel.leftAnchor.constraint(equalTo: mainDownStackView.leftAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dateLabel.topAnchor.constraint(equalTo: mainDownStackView.topAnchor, constant: 5).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDatePickerHandler))
        dateLabel.isUserInteractionEnabled = true
        dateLabel.addGestureRecognizer(tap)
        
        dateLabel.text =  dateFormatter.string(from: Date())
        
        textUIViews = [titleTextField,mainTextView]
    }
    
    private func setUpNavigationItems(){
        
        
       let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:  #selector(handleDeleteNote))
      
        let gpsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "geopos"), style: .plain, target: self, action: #selector(handleGeoPosition))
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicToTextView))
        
//        notebookButton = UIBarButtonItem(title: "Notebook", style: .plain, target: self, action: #selector(handleChangeNotebook))
//        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.title = "Nota"
        navigationController?.isToolbarHidden = false
        self.setToolbarItems([cameraButton,gpsButton], animated: true)
//        navigationItem.rightBarButtonItems = [deleteButton,gpsButton,cameraButton]
//        navigationItem.leftBarButtonItems = [notebookButton!,saveButton]
        navigationItem.rightBarButtonItems = [saveButton]
        
        
    }
    
 
    
   
    
    
   
}
