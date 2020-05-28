//
//  ShopBookTableViewCell.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 21/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class ShopBookTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfSteps: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
