// Authors
// Name: Hisahm Abu Sanimeh
// StudentID: 301289364
// Name: Fernando Quezada
// StudentID: 301286477

// Date: 27-Nov-2022

// App description:
// Assignment 5 – Todo List App - Part 2 - Logic for Data Persistence

import UIKit
import UserNotifications

// Class shows:
//code for notifications, the user can configure notifications using calendar
//load data
//save data
//complete tasks
//code for edit button

class ToDoListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    
    
    var toDoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Loading and verifing that the tasks are not out of date and then show them to the user.
        loadData()
        
        setSelectionCell(indexCell: 0)
        
        autherizeLocalNotifications()
    }
    
    
    func setSelectionCell( indexCell: Int){
        if (toDoItems.count > 0 ) {
            
            // Set all items of the array in selected cell to false except the index cell
            for index in 0..<toDoItems.count {
                toDoItems[index].isSelected = false
            }
            
            tableView.selectRow(at: IndexPath(row: indexCell, section: 0), animated: true,scrollPosition:.none )
            toDoItems[indexCell].isSelected = true
        
        }
    }
    
    func autherizeLocalNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print("😡 ERROR: \(error!.localizedDescription)")
                return
            }
            if granted {
                print ("✅ Notifications Authorization Granted!")
            } else {
                print("🚫 The user has denied notifications!")
                //TODO: put an alert in here telling the user what to do
            }
        }
    }
    
    func setNotifications(){
        guard toDoItems.count > 0 else {
            return
        }
        
        //remove all notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //Let's re-create them with the updated data that we just saved
        for index in 0..<toDoItems.count {
            if toDoItems[index].hasDueDate {
                let toDoItem = toDoItems[index]
                
                toDoItems[index].notificationID = setCalendarNotification(
                    title: toDoItem.name,
                    subtitle: "",
                    body: toDoItem.notes,
                    badgeNumber: nil,
                    sound: .default,
                    date: toDoItem.dueDate)
            }
        }
    }
    
    func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound:
            UNNotificationSound?, date: Date) -> String {
            // create content:
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            content.body = body
            content.sound = sound
            content.badge = badgeNumber
        
            //Create trigger
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            dateComponents.second = 00
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // Create request
            let notificationID = UUID().uuidString
            let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
            
            //Record the request with the notification center
            UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription) Yikes, adding notification request went wrong!")
            } else {
                print("Notification scheduled \(notificationID), title: \(content.title)")
            }
            
        }
        return notificationID
    }
    
    func validateTasks() {
        // Validate old dates for all items and set status task in 2 states
        for i in stride(from: 0 , to: toDoItems.count, by: 1) {
            
            // If item data has old data, it will change status to OverDue
            if (toDoItems[i].dueDate < Date() ){
                toDoItems[i].statusTask = 2
            }
            
            if (toDoItems[i].isCompleted == true){
                toDoItems[i].statusTask = 1
            }
        }
        
        saveData()
    }
    
    // upload json into array toDoItems
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            toDoItems = try jsonDecoder.decode(Array<ToDoItem>.self, from:data)
            
            //Validate that uploaded tasks are not out of date
            validateTasks()
            
            tableView.reloadData()
            
        } catch {
            print("😡, ERROR: Could, not load data\(error.localizedDescription)")
        }
    }
    
    func saveData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(toDoItems)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("😡, ERROR: Could, not save data\(error.localizedDescription)")
        }
        //let toDoItem = toDoItems.first!
        //let notificationID = setCalendarNotification(title: toDoItem.name, subtitle: "SUBTITLE would go here", body:
            //toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
        
        setNotifications()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! ToDoDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.toDoItem = toDoItems[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        var indexSelectedCell: Int
        let source = segue.source as! ToDoDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            indexSelectedCell = selectedIndexPath.row
            toDoItems[selectedIndexPath.row] = source.toDoItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            indexSelectedCell = toDoItems.count
            let newIndexPath = IndexPath(row: toDoItems.count, section: 0)
            toDoItems.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.reloadData()
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
            
        }
        
        //Set up the current selecction in the array
        setSelectionCell( indexCell: indexSelectedCell)
        
        saveData()
        loadData()
        setSelectionCell( indexCell: indexSelectedCell) 
    }
    // update is complete
    @IBAction func completeTaskSwitch(_ sender: UISwitch) {
       
        if let selectedCell = tableView.indexPathForSelectedRow{
            var indexSelectedCell: Int
            
            indexSelectedCell = selectedCell.row
            
            // The cell is selected
            if(sender.isOn == true){
                toDoItems[selectedCell.row].isCompleted = false
            } else {
                toDoItems[selectedCell.row].isCompleted = true
            }
            setSelectionCell( indexCell: indexSelectedCell)
            saveData()
            
            // reload all items with currend date
            loadData()
            setSelectionCell( indexCell: indexSelectedCell)
        } else {
            
        }
        
    }
    
    @IBAction func editButtomPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
            
        }
    }
    

}

// Standard Code for configure list cells of table view
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberOfRowsInSection was just called. Returning \(toDoItems.count)")
        return toDoItems.count
    }
    
    // Active status with all items from tableview reload
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellForRowAt was just called for indexPath.row = \(indexPath.row) which is the cell containing \(toDoItems[indexPath.row])")
        let customCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellTableViewCell
        
        let dataItem = toDoItems[indexPath.row] as ToDoItem // Get data for item array
        customCell.putDataInControlsCell(cellData: dataItem, indexRow: indexPath.row) // load information in view custom view cell, paint in red
        
        //cell.textLabel?.text = toDoArray[indexPath.row] //add array item to cell's textLabel (which xcode
        //gives us. indexPath.row is the array element number)
        
        // return a cell painted with data
        return customCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoItems[sourceIndexPath.row]
        toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
    }
    
}
