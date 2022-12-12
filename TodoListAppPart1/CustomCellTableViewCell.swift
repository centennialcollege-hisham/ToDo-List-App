// Authors
// Name: Hisahm Abu Sanimeh
// StudentID: 301289364
// Name: Fernando Quezada
// StudentID: 301286477

// Date: 27-Nov-2022

// App description:
// Assignment 5 – Todo List App - Part 2 - Logic for Data Persistence

import UIKit

private let dateFormatter: DateFormatter = {
    print("The date is wrong!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

// Class shows the code when the task is complete or not

class CustomCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
    }
    
    // Object from custom view cell title status and switch
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    var IndexCell: Int?
    // even for completed tasks
    
    // Show info data from array todoitems to Objects to custom cell in table view list
    func putDataInControlsCell(cellData: ToDoItem , indexRow: Int ){
        
        IndexCell = indexRow

        
        if(cellData.statusTask == 1){
                        
            let attributedText = NSAttributedString(
                string: cellData.name,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            
            labelTitle.attributedText = attributedText
            labelTitle.textColor = UIColor.black
            labelStatus.text = "Completed"
            labelStatus.textColor = UIColor.black
            
        } else if (cellData.statusTask == 2){
            let attributedText = NSAttributedString(
                string: cellData.name
            )
            
            labelTitle.attributedText = attributedText
            labelTitle.textColor = UIColor.red
            
            let dueDate  = dateFormatter.string(from: cellData.dueDate)
            labelStatus.text = "OverDue! \(dueDate)  "
            labelStatus.textColor = UIColor.red
           
        } else if (cellData.statusTask == 0){
            
            let attributedText = NSAttributedString(
                string: cellData.name
            )
            
            labelTitle.attributedText = attributedText
            labelTitle.textColor = UIColor.black
            
            labelStatus.text = dateFormatter.string(from: cellData.dueDate)
            labelStatus.textColor = UIColor.black
           
        } else {
            labelTitle.text = cellData.name
        }

        
    }
    
    
}
