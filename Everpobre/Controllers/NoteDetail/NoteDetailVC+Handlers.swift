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
        guard let date = dateFormatter.date(from: dateLabel.text!)  else {return}
        let text = mainTextView.text ?? ""
        let address = addressLabel.text ?? ""
        let arrayImage = imageArray
        if title.isEmpty {
            showError(title: "The note title can't be empty")
            return
        }
 
        
        //la nota se actualiza
        if indexPath != nil{
            self.setNote(title: title, text: text, date: date, images:arrayImage , address: address )
            
              CoreDataManager.shared.updateNote(note: note!)
            if(originalNotebook != notebook ){
                self.delegate?.didDeleteNote(indexPath: indexPath!,note: note!)
                self.delegate?.didAddNote(note: note!)
            }else{
               
                self.delegate?.didUpdateNote( indexPath: indexPath!)
                
            }
        
        //la note se crea
        }else{
            let tuple = CoreDataManager.shared.createNote(title: title, date:date, notebook: self.notebook!, text: text , images: arrayImage, address: address )
            
            if(tuple.0 != nil){
                self.delegate?.didAddNote(note: tuple.0!)
            }
        }
        
        navigationController?.popViewController(animated: true)
       
    }
    @objc  func showDatePickerHandler(){

        let datePickerModal = ModalDatePickerViewController()
        datePickerModal.delegate = self
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
        //TODO Delete note
        print("borrando")
    }
    
    @objc  func handleGeoPosition(){
         let modalLocationViewController = ModalLocationViewController()
        modalLocationViewController.delegate = self
        present(modalLocationViewController.wrappedInNavigation(), animated: true)
    }
    
    
    //MARK: - gesture handlers
    
    @objc  func handleImageRotation(rotationGesture: UIRotationGestureRecognizer){
         currentImageIndex = imageArray.index(of: rotationGesture.view as! UIImageView)
        self.view.bringSubview(toFront:  (rotationGesture.view)!)
//          let location = rotationGesture.location(in: mainTextView)
        switch rotationGesture.state {
            case .began:
                relativePoint = rotationGesture.location(in:rotationGesture.view)
            case .changed:
                relativePoint = rotationGesture.location(in:rotationGesture.view)
                rotationGesture.view?.transform  = CGAffineTransform(rotationAngle:  rotationGesture.rotation )

            case .ended:
                   imageArray[currentImageIndex].transform.rotated(by: rotationGesture.rotation)
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
            case .began:
                    break
            case .changed:
                pinchGesture.view?.transform = (pinchGesture.view?.transform)!.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
                pinchGesture.scale = 1
            case .ended, .cancelled:

                imageArray[currentImageIndex].heightAnchor.constraint(equalTo: (pinchGesture.view?.heightAnchor)!)
                imageArray[currentImageIndex].widthAnchor.constraint(equalTo: (pinchGesture.view?.widthAnchor)!)
     
            default:
            break
        }
        
        
    }
    
    @objc  func handleMoveImage(longPressGesture: UILongPressGestureRecognizer){
        
        guard let gestureView = longPressGesture.view  else {return}
        let imageView = longPressGesture.view as! UIImageView
        currentImageIndex = imageArray.index(of:imageView)
        
        switch longPressGesture.state {
            case .began:
                self.closeKeyboard()
                relativePoint = longPressGesture.location(in:gestureView)
            case .changed:
                let location = longPressGesture.location(in: mainTextView)
                longPressGesture.view?.transform   = CGAffineTransform(translationX: location.x - relativePoint.x , y:location.y - relativePoint.y )
            case .ended, .cancelled:
                break
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
    
    //MARK: - notehandler
    
    func setNote(title:String,text:String,date:Date, images: [UIImageView]?,address:String){
        
        note?.title = title
        note?.text = text
        note?.date = date
        note?.notebook = notebook
        note?.address = address
        CoreDataManager.shared.updateNote(note:note!)
        CoreDataManager.shared.createImages(images: images!,note: note!)
      
       
       
    }
    
    func setUpImages(images:NSSet){

        images.allObjects.forEach{
            let image = $0 as! Image
             let imageView = UIImageView()
            imageView.image = UIImage(data: image.imageData!)
            view.addSubview(imageView)
            imageView.frame = CGRect(x: image.position_x, y: image.position_y, width: Double(100), height: Double(100))
           // imageView.frame = CGRect(x: (image.position_x), y: (image.position_y), width: image.width , height: image.height )
            imageView.isUserInteractionEnabled = true
            //imageView.addGestureRecognizer( UIPinchGestureRecognizer(target: self, action: #selector(handleImagePinch)))
            //imageView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(handleImageRotation)))
            imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleMoveImage)))
            
           
            imageArray.append(imageView)
      
            
           
        }

        
    
    }

    
}
