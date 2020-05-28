//
//  LibraryTableViewCell.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 20/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    //Cell book information label outlets
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var currentChapterLabel: UILabel! // OLIVIER : I have changed the ? with a !
    @IBOutlet weak var percentCompleteLabel: UILabel!
    
    //Cell book cover outlet
    @IBOutlet var bookCoverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addImage(){
        bookCoverImage.frame = CGRect(x: 10, y: 10, width: 120, height: 170)
        self.addSubview(bookCoverImage)
    }

}
