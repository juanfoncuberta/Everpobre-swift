//
//  ModalDatePickerViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 22/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit

protocol ModalDatePickerViewControllerDelegate {
    func dateDidChange(date:String)
}

class ModalDatePickerViewController: UIViewController{
    
    var delegate: ModalDatePickerViewControllerDelegate!
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePickerMode.date
        dp.backgroundColor = UIColor.white
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()

        
    }
    private func setupDatePicker(){
        view.backgroundColor = UIColor(white:1,alpha:0.2)
      

        let datePickerContainer = UIView()
        view.addSubview(datePickerContainer)
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        datePickerContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePickerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePickerContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        datePickerContainer.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
 
        let stackViewContainer = UIView()
        view.addSubview(stackViewContainer)
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: datePickerContainer.topAnchor).isActive = true
        stackViewContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackViewContainer.backgroundColor = .white
        
        
//        let stackView = UIStackView()
//        stackViewContainer.addSubview(stackView)
//        stackView.axis = .horizontal
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.bottomAnchor.constraint(equalTo: datePicker.topAnchor).isActive = true
//        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let doneButton = UIButton()
        stackViewContainer.addSubview(doneButton)
        doneButton.setTitle("Done", for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: stackViewContainer.rightAnchor, constant: -20).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: stackViewContainer.centerYAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        doneButton.tintColor = .blue
        doneButton.addTarget(self, action: #selector(handleSaveDate), for: .touchUpInside)
      
        doneButton.setTitleColor(UIColor.blue, for: .normal)
        
    }

    @objc func handleSaveDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.delegate.dateDidChange(date: dateFormatter.string(from: datePicker.date))
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
