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
    
    var IndexCell: Int?
    // even for completed tastk
    
    // Show info data from array todoitems to Objects to custom cell in list table view
    func putDataInControlsCell(cellData: ToDoItem , indexRow: Int ){
        
        IndexCell = indexRow
        
        if (cellData.isCompleted == true){
            switchStatus.isOn = false
        } else {
            switchStatus.isOn = true
        }
        
        if(cellData.statusTask == 1){
            
            //switchStatus.setOn(false, animated: false)
            
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
            // cero
            // la tarea esta en estado activa  porlotanto se debe hacer un
            // analisis de la fecha de estado pero en la carga de datos no aqui aqui solo se muestra
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
