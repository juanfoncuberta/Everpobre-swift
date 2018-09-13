//
//  NoteDetailVC+ImagePicker.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 7/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit


extension NoteDetailViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let imageView = UIImageView()
        
        if let editedImage = info[UIImagePickerControllerEditedImage]{
            imageView.image = editedImage as? UIImage
        }else if let originalImage = info[UIImagePickerControllerOriginalImage]{
            imageView.image = originalImage as? UIImage
        }
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        

        
        imageView.topAnchor.constraint(equalTo: mainTextView.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: mainTextView.leftAnchor, constant: 10).isActive = true

        imageView.isUserInteractionEnabled = true
        
        
        //imageView.addGestureRecognizer( UIPinchGestureRecognizer(target: self, action: #selector(handleImagePinch)))
        //imageView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(handleImageRotation)))
        imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleMoveImage)))
        imageArray.append(imageView)
//        bezierImage(image: imageView)
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func bezierImage(image:UIImageView)
    {
        var rect = view.convert((imageArray.last?.frame)!, to: mainTextView)
        rect = rect.insetBy(dx: -15, dy: -15)
        
        let paths = UIBezierPath(rect: rect)
        mainTextView.textContainer.exclusionPaths = [paths]
    }
}
