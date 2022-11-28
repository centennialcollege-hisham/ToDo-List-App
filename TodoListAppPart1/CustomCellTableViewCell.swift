//
//  CustomCellTableViewCell.swift
//  TodoListAppPart1
//
//  Created by Victor Quezada on 2022-11-27.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("The date is wrong!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

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
    @IBOutlet weak var switchStatus: UISwitch!
    
    // Show info data from array todoitems to Objects to custom cell in list table view
    func setupCell(cellData: ToDoItem){
        
        labelTitle.text = cellData.name
        
        if(cellData.statusTask == 1){
            labelStatus.text = "Completed"
            switchStatus.setOn(false, animated: false)
            
            let attributedText = NSAttributedString(
                string: cellData.name,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            labelTitle.attributedText = attributedText
            
        } else if (cellData.statusTask == 2){
            labelStatus.text = "OverDue!"
            labelStatus.textColor = UIColor.red
            labelTitle.textColor = UIColor.red
        } else if (cellData.statusTask == 0){
            // cero
            labelStatus.text = dateFormatter.string(from: cellData.date)
        }

        
    }
    
    
}
