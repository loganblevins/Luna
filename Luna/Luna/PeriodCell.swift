//
//  PeriodCell.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class PeriodCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellUI( date: Date, endDate: Date )
    {
        labelDate.text =  setDisplayCurrentDate( date: date )
        labelEndDate.text = setDisplayCurrentDate( date: endDate )
    }
    
    fileprivate func setDisplayCurrentDate( date: Date ) -> String
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: currentDate)
    }
    
    
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!

}
