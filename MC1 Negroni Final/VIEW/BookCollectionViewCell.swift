//
//  BookCollectionViewCell.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 27/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit


class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addImage()
        contentView.addSubview(imageView)
        
    }
    
    func addImage(){
        if image != nil {
            print("adding image")
            imageView = UIImageView(image: image)
        }
    }
    
    
}
