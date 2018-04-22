//
//  NoteDetailViewController.swift
//  Everpobre
//
//  Created by Juan Foncuberta on 1/4/18.
//  Copyright © 2018 Juan Foncuberta. All rights reserved.
//

import UIKit
import MapKit
protocol NoteDetailViewControllerDelegate {
    func didAddNote(note:Note)
    func didUpdateNote(indexPath:IndexPath)
}
class NoteDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: - Properties
    var note:Note?{
        didSet{
            titleTextField.text = note?.title
            notebookNameLabel.text = note?.notebook?.name
            dateLabel.text = dateFormatter.string(from: (note?.date)!)
            mainTextView.text = note?.text
            addressLabel.text = note?.address
        }
    }
    let widthLabels: CGFloat = 75
    var notebookButton: UIBarButtonItem?
    

    var tapView: UITapGestureRecognizer!
    var datePickerOpened: Bool = false 

    var indexPath:IndexPath?
    var currentImageIndex:Int!
    var textUIViews: [UIView]!
    var delegate: NoteDetailViewControllerDelegate?
    var relativePoint: CGPoint!
    var notebook: Notebook?{
        didSet{
            
            notebookNameLabel.text = notebook?.name
        }
    }
    var imageArray = [UIImageView]()
    let stackViewContainer: UIView = {
        let stackVC = UIView()
        return stackVC
    }()
    let titleLabel: UILabel = {
        let titleLab = UILabel()
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.text = "Title:"
        return titleLab
    }()
    var titleTextField: UITextField = {
       
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Note title"
        return textField
    }(){
        didSet{
            note?.title = titleTextField.text
        }
        
    }
    
    let titleNotebookNameLabel: UILabel = {
        let titleNbNameLabel = UILabel()
        titleNbNameLabel.text = "Notebook:"
        titleNbNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleNbNameLabel
    }()
    let notebookNameLabel: UILabel = {
        let nbnLabel = UILabel()
        nbnLabel.translatesAutoresizingMaskIntoConstraints = false
  
        return nbnLabel
    }()

    let mainTextView: UITextView = {
     
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
    

        return textView
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePickerMode.date
        dp.addTarget(self, action: #selector(datePickerValueChangedHandler), for: UIControlEvents.valueChanged)
        dp.backgroundColor = UIColor.lightGray
        return dp
    }()
    
    let dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    let titleDateLabel:UILabel = {
        let titleDateLab = UILabel()
        titleDateLab.text = "Date:"
        titleDateLab.translatesAutoresizingMaskIntoConstraints = false
        return titleDateLab
    }()
    var dateLabel:UILabel = {
        let dLabel = UILabel()
        
        dLabel.translatesAutoresizingMaskIntoConstraints = false
       
        dLabel.textColor = .black
        
        return dLabel
        }(){
        didSet{
           
            note?.date =  dateFormatter.date(from: dateLabel.text!)
        }
    }
    let titleAddressLabel: UILabel = {
        let titleAddressLab = UILabel()
        titleAddressLab.text = "Location:"
        titleAddressLab.translatesAutoresizingMaskIntoConstraints = false
        return titleAddressLab
    }()
    var addressLabel:UILabel = {
        let addrLabel = UILabel()
        addrLabel.translatesAutoresizingMaskIntoConstraints = false
        addrLabel.textColor = .black
        return addrLabel
    }()
    
    var topImageConstraint: NSLayoutConstraint!
    var bottomImageConstraint: NSLayoutConstraint!
    var leftImageConstraint: NSLayoutConstraint!
    var rightImageConstraint: NSLayoutConstraint!
    
  
    //MARK: - init
    
    convenience init(){
        self.init(notebook: nil, delegate: nil)
    }
    
    init(notebook:Notebook?,delegate:NoteDetailViewControllerDelegate?,indexPath:IndexPath?){
        self.notebook = notebook
        self.delegate = delegate
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    convenience init(notebook:Notebook?,delegate:NoteDetailViewControllerDelegate?){
       
      self.init(notebook: notebook, delegate: delegate, indexPath: nil)
         
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Default view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBlue
                
        setupUI()
        notebookNameLabel.text = notebook?.name
    }

}
