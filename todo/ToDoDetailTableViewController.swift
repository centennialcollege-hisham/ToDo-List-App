
// File name: ToDoDetailTableViewController.swift

// Authors
// Name: Hisahm Abu Sanimeh
// StudentID: 301289364
// Name: Fernando Quezada
// StudentID: 301286477

// Date: 13-Nov-2022

// App description:
// Assignment 4 – Todo List App - Part 1 - Create the app UI

// Version: xCode 14.0.1

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var noteView: UITextView!
    
    
    var toDoItem : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem != nil {
            nameField.text = toDoItem
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = nameField.text
    }


    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true,completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
