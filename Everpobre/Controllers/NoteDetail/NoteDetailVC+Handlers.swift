//
//  NoteDetailVC+Handlers.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 7/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
import CoreGraphics


extension NoteDetailViewController{
    
    //MARK: - outlet handlers
    @objc  func handleSave(){
        guard let title = titleTextField.text else {return}
        guard let date = dateLabel.text else {return}
        let text = mainTextView.text ?? ""
        let address = addressLabel.text ?? ""

        if title.isEmpty {
            showError(title: "The note title can't be empty")
            return
        }
        //la nota se actualiza
        if indexPath != nil{
            self.setNote(title: title, text: text, date: date, images:nil , address: address)
            
            
            if(originalNotebook != notebook ){
                self.delegate?.didDeleteNote(indexPath: indexPath!,note: note!)
                 CoreDataManager.shared.updateNote(note: note!)
                self.delegate?.didAddNote(note: note!)
            }else{
                 CoreDataManager.shared.updateNote(note: note!)
                self.delegate?.didUpdateNote( indexPath: indexPath!)
                
            }
            
           
           
            
        
        //la note se crea
        }else{
            let tuple = CoreDataManager.shared.createNote(title: title, date: Date(), notebook: self.notebook!, text: text , images: nil, address: address)
            
            
            if(tuple.0 != nil){
                self.delegate?.didAddNote(note: tuple.0!)
            }
        }

        
        
        navigationController?.popViewController(animated: true)
       
    }
    @objc  func showDatePickerHandler(){

        let datePickerModal = ModalDatePickerViewController()
        datePickerModal.delegate = self
        
//        datePicker.frame = CGRect(x: 0.0, y: view.frame.height-250, width: view.frame.width, height: 250)
//        datePicker.date = dateFormatter.date(from: dateLabel.text!)!
//        showDatePicker(show: !datePickerOpened, animateTime: 0.5)
        self.present(datePickerModal,animated: true)
       
    }
    

    @objc  func datePickerValueChangedHandler(datePicker:UIDatePicker){
 
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @objc  func addPicToTextView(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController,animated: true,completion:nil)
    }
    
    @objc  func handleDeleteNote(){
        print("borrando")
    }
    
    @objc  func handleGeoPosition(){
        print("getting geo pos...")
         let modalLocationViewController = ModalLocationViewController()
        modalLocationViewController.delegate = self
        present(modalLocationViewController.wrappedInNavigation(), animated: true)
    }
    
    
    //MARK: - gesture handlers
    
    @objc  func handleImageRotation(rotationGesture: UIRotationGestureRecognizer){
         currentImageIndex = imageArray.index(of: rotationGesture.view as! UIImageView)
         self.view.bringSubview(toFront:  (rotationGesture.view)!)
        switch rotationGesture.state {
        case .began:
            relativePoint = rotationGesture.location(in:rotationGesture.view)
            let location = rotationGesture.location(in: mainTextView)
         
            print(rotationGesture.rotation)
//            leftImageConstraint.constant = location.x - relativePoint.x
//            topImageConstraint.constant = location.y - relativePoint.y
        case .changed:
            print("changed")
        
//
            rotationGesture.view?.transform  = CGAffineTransform(rotationAngle:  rotationGesture.rotation )

            print(rotationGesture.rotation)
           

        case .ended:
               imageArray[currentImageIndex].transform.rotated(by: rotationGesture.rotation)
            print("ended")
        default:
            break
        }
//        if let gestureView = rotationGesture.view {
//            gestureView.transform = view.transform.rotated(by: rotationGesture.rotation)
//            rotationGesture.rotation = 1
//        }
    }
    
    @objc  func handleImagePinch(pinchGesture: UIPinchGestureRecognizer){
        currentImageIndex = imageArray.index(of: pinchGesture.view as! UIImageView)

        switch pinchGesture.state {
        case .changed:
           
            pinchGesture.view?.transform = (pinchGesture.view?.transform)!.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
            pinchGesture.scale = 1
        case .ended, .cancelled:
            print("ended")
            
            imageArray[currentImageIndex].heightAnchor.constraint(equalTo: (pinchGesture.view?.heightAnchor)!)
            imageArray[currentImageIndex].widthAnchor.constraint(equalTo: (pinchGesture.view?.widthAnchor)!)
//            imageArray[currentImageIndex].topAnchor.constraint(equalTo: (pinchGesture.view?.topAnchor)!)
//            imageArray[currentImageIndex].leftAnchor.constraint(equalTo: (pinchGesture.view?.leftAnchor)!)
        //            gestureView.frame.heigh
            
            print("endpinch")
            print( imageArray[currentImageIndex].frame.height)
       
        default:
            print("default")
        }
        
        
    }
    
    @objc  func handleMoveImage(longPressGesture: UILongPressGestureRecognizer){
        
        guard let gestureView = longPressGesture.view  else {return}
        currentImageIndex = imageArray.index(of: longPressGesture.view as! UIImageView)
        
        switch longPressGesture.state {
        case .began:
//            closekeyboard()
            print("began")
     
            relativePoint = longPressGesture.location(in:gestureView)
            
        case .changed:
            let location = longPressGesture.location(in: mainTextView)
            print("changed")
            print( imageArray[currentImageIndex].frame.height)
            print(gestureView.frame.height)
            longPressGesture.view?.transform   = CGAffineTransform(translationX: location.x - relativePoint.x , y:location.y - relativePoint.y  )
//            leftImageConstraint.constant = location.x - relativePoint.x
//            topImageConstraint.constant = location.y - relativePoint.y
            
            
        case .ended, .cancelled:
            imageArray[currentImageIndex].topAnchor.constraint(equalTo: (longPressGesture.view?.topAnchor)!)
            imageArray[currentImageIndex].leftAnchor.constraint(equalTo: (longPressGesture.view?.leftAnchor)!)
            
//            UIView.animate(withDuration: 01, animations: {
//                gestureView.transform = CGAffineTransform.init(scaleX:1,y:1)
//            })
        default:
            break
        }
        
    }
    
    //MARK: - Notebook modal handler
    @objc func tapNotebookNameLabelHandler(tapgesture: UITapGestureRecognizer){
        let modalNotebookVC = ModalNotebookViewController(delegate: self, titleText: "Select the note's notebook", forCreateNewNote: true)
        modalNotebookVC.notebooks = CoreDataManager.shared.fetchNotebooks()
        self.present(modalNotebookVC.wrappedInNavigation(), animated: true, completion: nil)
        
    }
    
    //MARK: - datepicker handler
//    func showDatePicker(show: Bool, animateTime: TimeInterval) {
//        // set state variable
//        self.closeKeyboard(views: textUIViews)
//        datePickerOpened = show
//        datePicker.isHidden = !show
//
//    }
    
    //MARK: - notehandler
    
    func setNote(title:String,text:String,date:String, images: [UIImage]?,address:String){
        
        note?.title = title
        note?.text = text
        note?.date = dateFormatter.date(from: date)
        note?.notebook = notebook
        note?.address = address
        
        
    }
    
//(title: title, date: Date(), notebook: self.notebook!, text: text , images: nil, latitude: nil, longitude: nil)
    
}
