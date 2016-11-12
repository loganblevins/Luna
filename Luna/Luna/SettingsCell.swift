//
//  BirthControlCell.swift
//  Luna
//
//  Created by Erika Wilcox on 11/10/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell
{

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellUI( title: String, user: User )
    {
        labelTitle.text = title
        labelValue.text = user.birthControl
    }
    

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!
}
