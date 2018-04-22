//
//  NoteDetailVC+UI.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 1/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
import MapKit
extension NoteDetailViewController{
    //MARK: - Properties
    
    
     func setupUI(){
        setUpNavigationItems()
        setUpMainBarItems()
        setUpTextLabel()

    }
    
    

    private func setUpTextLabel(){
        
        view.addSubview(mainTextView)
        
        mainTextView.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: 5).isActive = true
        mainTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mainTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//        mainTextView.addCornerAndBorder(color: .blue)
        

     
    
    }
    
    
   
    
    private func setUpMainBarItems(){
     
        let mainUpStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
        let mainMiddleStackView = UIStackView(arrangedSubviews: [titleDateLabel, dateLabel, titleNotebookNameLabel,notebookNameLabel])
        let mainDownStackView = UIStackView(arrangedSubviews: [titleAddressLabel,addressLabel])
       let mainStackView = UIStackView(arrangedSubviews: [mainUpStackView,mainMiddleStackView,mainDownStackView])
        
        view.addSubview(stackViewContainer)
        
     
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
             stackViewContainer.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        } else {

            stackViewContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        }
        stackViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
//        mainUpStackView.translatesAutoresizingMaskIntoConstraints = false
        mainUpStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor).isActive = true
        mainUpStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
//        mainUpStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        
        mainMiddleStackView.axis = .horizontal
        mainMiddleStackView.topAnchor.constraint(equalTo: mainUpStackView.bottomAnchor, constant: 5).isActive = true
        mainMiddleStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        
        mainDownStackView.axis = .horizontal
        mainDownStackView.topAnchor.constraint(equalTo: mainMiddleStackView.bottomAnchor,constant:5).isActive = true
        mainDownStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        
        
        titleLabel.textColor = .black
        titleLabel.leftAnchor.constraint(equalTo: mainUpStackView.leftAnchor, constant: 5).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: widthLabels).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainUpStackView.topAnchor,constant: 5).isActive = true

        titleTextField.textColor = .black
        titleTextField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
        


        titleDateLabel.textColor = .black
        titleDateLabel.leftAnchor.constraint(equalTo: mainMiddleStackView.leftAnchor, constant: 5).isActive = true
        titleDateLabel.widthAnchor.constraint(equalToConstant: widthLabels).isActive = true
        titleDateLabel.topAnchor.constraint(equalTo: mainMiddleStackView.topAnchor, constant: 5).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: titleDateLabel.rightAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleDateLabel.topAnchor, constant: 5).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDatePickerHandler))
        dateLabel.isUserInteractionEnabled = true
        dateLabel.addGestureRecognizer(tap)
        dateLabel.text =  dateFormatter.string(from: Date())
        
        
        titleNotebookNameLabel.textColor = .black
        titleNotebookNameLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10).isActive = true
        titleNotebookNameLabel.topAnchor.constraint(equalTo: mainMiddleStackView.topAnchor, constant: 5).isActive = true
        titleNotebookNameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        notebookNameLabel.textColor = .black
        notebookNameLabel.leftAnchor.constraint(equalTo: titleNotebookNameLabel.rightAnchor).isActive = true
        notebookNameLabel.topAnchor.constraint(equalTo: titleNotebookNameLabel.topAnchor).isActive = true
        
        let tapNotebookNameLabel = UITapGestureRecognizer(target: self, action: #selector(tapNotebookNameLabelHandler))
        notebookNameLabel.isUserInteractionEnabled = true
        notebookNameLabel.addGestureRecognizer(tapNotebookNameLabel)
        
        
        titleAddressLabel.textColor = .black
        titleAddressLabel.topAnchor.constraint(equalTo: mainDownStackView.topAnchor, constant: 5).isActive = true
        titleAddressLabel.leftAnchor.constraint(equalTo: mainDownStackView.leftAnchor, constant: 5).isActive = true
        titleAddressLabel.widthAnchor.constraint(equalToConstant: widthLabels).isActive = true
        
        addressLabel.textColor = .black
        addressLabel.topAnchor.constraint(equalTo: titleAddressLabel.topAnchor).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: titleAddressLabel.rightAnchor, constant: 5).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        textUIViews = [titleTextField,mainTextView]
    }
    
    private func setUpNavigationItems(){
        
        
       let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:  #selector(handleDeleteNote))
      let a = UIBarButtonItem(barButtonSystemItem:.flexibleSpace , target: self, action: nil)

        let gpsButton = UIBarButtonItem(title: "Location", style: .plain, target: self, action: #selector(handleGeoPosition))
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicToTextView))
        gpsButton.width = 25;
       
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.title = "Nota"
        navigationController?.isToolbarHidden = false


        self.setToolbarItems([cameraButton,a,gpsButton], animated: true)
        navigationItem.rightBarButtonItems = [saveButton]
        
        
    }
    
 
    
   
    
    
   
}
