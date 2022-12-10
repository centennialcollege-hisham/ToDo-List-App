// File name: ViewController.swift

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

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!


    //var arrTodoItems = [TodoItem]()
    
    var arrTodoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
        
        
        // add list data
//        arrTodoItems.append(TodoItem(title: "Assigment2", date: "", desc: "", status: 1))
//        arrTodoItems.append(TodoItem(title: "Assigment3", date: "Sunday 13 NOV", desc: "", status: 2))
//        arrTodoItems.append(TodoItem(title: "Assigment4", date: "Sunday 13 NOV", desc: "", status: 3))
//        arrTodoItems.append(TodoItem(title: "Assigment6", date: "", desc: "", status: 1))

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as!  ToDoDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.toDoItem = arrTodoItems[selectedIndexPath.row].title
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
    }

    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            arrTodoItems = try jsonDecoder.decode(Array<TodoItem>.self, from:data)
            tableView.reloadData()
        } catch {
            print("😡, ERROR: Could, not load data\(error.localizedDescription)")
        }
    }
    
    
    func saveData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json") // app/todos.json
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(arrTodoItems)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("😡, ERROR: Could, not save data\(error.localizedDescription)")
        }
        
        //setNotifications()
        
    }
    
    
    
    
    // to receive the data from details and apply it - TODO
    
//    @IBAction func unwindFromDetails(seque:UIStoryboardSegue){
//        let source = seque.source as! ToDoDetailTableViewController
//        if let selectedIndexPath = tableView.indexPathForSelectedRow{
//            arrTodoItems[selectedIndexPath.row] = source.toDoItem
//            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
//        } else {
//            let newIndexPath = IndexPath(row: arrTodoItems.count, section: 0)
//            arrTodoItems.append(source.toDoItem)
//            tableView.insertRows(at: [newIndexPath], with: .bottom)
//            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
//        }
//
//
//    }

}



// Implement the table view and set the count and cell data
extension TodoViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTodoItems.count
    }
    
    // show all items of table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        let data = arrTodoItems[indexPath.row] as TodoItem
        cell.setupCell(data: data)
        return cell
    }
    
    
}




