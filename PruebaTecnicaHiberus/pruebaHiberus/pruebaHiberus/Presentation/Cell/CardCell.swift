//
//  CardCell.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNanacost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
