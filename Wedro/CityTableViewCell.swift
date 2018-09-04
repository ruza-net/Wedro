//
//  CityTableViewCell.swift
//  Wedro
//
//  Created by Jan Růžička on 03/09/2018.
//  Copyright © 2018 Jan Růžička. All rights reserved.
//

import UIKit


class CityTableViewCell: UITableViewCell {
    
    // MARK: Properties
    //
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    // MARK: Inherited Methods
    //
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
