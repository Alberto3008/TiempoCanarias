//
//  ClimaTableViewCell.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 2/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

class ClimaTableViewCell: UITableViewCell {

    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var imagenView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
