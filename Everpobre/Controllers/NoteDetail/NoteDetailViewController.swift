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
}
class NoteDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: - Properties
    var note:Note?{
        didSet{
            titleTextField.text = note?.title
            notebookNameLabel.text = note?.notebook?.name
            dateLabel.text = dateFormatter.string(from: (note?.date)!)
            mainTextView.text = note?.text
           
            
            
        }
    }
    
    var notebookButton: UIBarButtonItem?
//    {
//        didSet{
//            notebookNameLabel.text = notebook?.name
//        }
//    }
    var tapView: UITapGestureRecognizer!
    var datePickerOpened: Bool = false 
//    weak var mapView: MKMapView?
    var currentImageIndex:Int!
    var textUIViews: [UIView]!
    var delegate: NoteDetailViewControllerDelegate?
//    var delegate: UIViewController?
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
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Note title"
        return textField
    }()
    
    let notebookNameLabel: UILabel = {
        let nbnLabel = UILabel()
        nbnLabel.translatesAutoresizingMaskIntoConstraints = false
        nbnLabel.text = "Notebook name"
        return nbnLabel
    }()
    
  
    
    
    
  
    let mainTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
 
        textView.text = "Write here..."
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
    let dateLabel:UILabel = {
        let dLabel = UILabel()
        
        dLabel.translatesAutoresizingMaskIntoConstraints = false
       
        dLabel.textColor = .black
        
        return dLabel
    }()
    
    var topImageConstraint: NSLayoutConstraint!
    var bottomImageConstraint: NSLayoutConstraint!
    var leftImageConstraint: NSLayoutConstraint!
    var rightImageConstraint: NSLayoutConstraint!
    
  
    //MARK: - init
    
    convenience init(){
        self.init(notebook: nil, delegate: nil)
    }
    
    init(notebook:Notebook?,delegate:NoteDetailViewControllerDelegate?){
        self.notebook = notebook
        self.delegate = delegate
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK: - UI
   
    

}
