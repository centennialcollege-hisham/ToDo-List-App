//
//  ToDoDetailTableViewController.swift
//  TodoListAppPart1
//
//  Created by Victor Quezada on 2022-11-24.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("I JUST CREATED A DATE FORMATTER!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    var toDoItem: ToDoItem!
    
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    let notesRowHeight: CGFloat = 200
    let defaultRowHeight: CGFloat = 44
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil {
            toDoItem = ToDoItem(isSelected: false,
                                name: "",
                                dueDate: Date().addingTimeInterval(24*60*60),
                                notes: "",
                                isCompleted: false,
                                statusTask: 0,
                                hasDueDate: false)
            nameField.becomeFirstResponder()
        }
        updateUserInterface()
        
    }
    
    func updateUserInterface(){
        // Show data in view
        nameField.text = toDoItem.name
        datePicker.date = toDoItem.dueDate
        noteView.text = toDoItem.notes
        reminderSwitch.isOn = toDoItem.hasDueDate
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
        dateLabel.text = dateFormatter.string(from: toDoItem.dueDate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get data from viewform to itemclass cell toDoitem
        toDoItem = ToDoItem(name: nameField.text!,
                            dueDate: datePicker.date,
                            notes: noteView.text,
                            statusTask: 0 ,
                            hasDueDate: reminderSwitch.isOn)
    }
    

    @IBAction func cancelButtonPress(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    @IBAction func reminderSwitchChanged(_ sender: UISwitch) {
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
        
    }
}

extension ToDoDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return reminderSwitch.isOn ? datePicker.frame.height : 0
        case notesTextViewIndexPath:
            return notesRowHeight
        default:
            return defaultRowHeight
        }
    }
}
