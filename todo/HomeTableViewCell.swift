
// File name: HomeTableViewCell.swift

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

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var switchStatus: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // fill data on cell views
    func setupCell(data:TodoItem){
        
        labelTitle.text = data.title
        
        if(data.status == 1){
            labelStatus.text = "Completed"
            switchStatus.setOn(false, animated: false)
            
            let attributedText = NSAttributedString(
                string: data.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            labelTitle.attributedText = attributedText
            
        } else if (data.status == 2){
            labelStatus.text = "OverDue!"
            labelStatus.textColor = UIColor.red
            labelTitle.textColor = UIColor.red
        } else {
            labelStatus.text = data.date
        }

        
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
