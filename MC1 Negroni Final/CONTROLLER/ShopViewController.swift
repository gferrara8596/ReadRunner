//
//  SummaryViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 20/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    var images = [UIImage]()
 
    @IBOutlet weak var shopCollection1: UICollectionView!
    
    @IBOutlet weak var shopCollection2: UICollectionView!
    
    @IBOutlet weak var shopCollection3: UICollectionView!
    
    @IBOutlet weak var mostPopularLabel: UILabel!
    @IBOutlet weak var recentlyAddedLabel: UILabel!
    @IBOutlet weak var otherLanguagesLabel: UILabel!
    
    override func viewDidLoad() {
        print("shopViewController Called")
        super.viewDidLoad()
        loadImages()
        view.addSubview(shopCollection1)
        shopCollection1.delegate = self
        shopCollection1.dataSource = self
        view.addSubview(shopCollection1)
        shopCollection2.delegate = self
        shopCollection2.dataSource = self
        view.addSubview(shopCollection2)
        shopCollection3.delegate = self
        shopCollection3.dataSource = self
        view.addSubview(shopCollection3)
        
        mostPopularLabel.font = UIFont(name: "SFProDisplay-Heavy", size: 22)
        recentlyAddedLabel.font = UIFont(name: "SFProDisplay-Heavy", size: 22)
        otherLanguagesLabel.font = UIFont(name: "SFProDisplay-Heavy", size: 22)

    }


}

extension ShopViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView Called")
        let cellIdentifier = "shopCell1"
        let cell = shopCollection1.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookCollectionViewCell
        
        cell.image = images[indexPath.row]
        cell.imageView = UIImageView(image: cell.image)
        cell.contentView.addSubview(cell.imageView)
        cell.imageView.frame = CGRect(x: 10, y: 10, width: 137, height: 185)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
      numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func loadImages(){
        let path1 = Bundle.main.path(forResource: "image1.jpg", ofType: nil)!
        let path2 = Bundle.main.path(forResource: "image2.jpg", ofType: nil)!
        let path3 = Bundle.main.path(forResource: "image3.jpg", ofType: nil)!
        let path4 = Bundle.main.path(forResource: "image4.jpg", ofType: nil)!
        let path5 = Bundle.main.path(forResource: "image5.jpg", ofType: nil)!
        let path6 = Bundle.main.path(forResource: "image6.jpg", ofType: nil)!
        let path7 = Bundle.main.path(forResource: "image7.jpg", ofType: nil)!
        let path8 = Bundle.main.path(forResource: "image8.jpeg", ofType: nil)!
        let path9 = Bundle.main.path(forResource: "image9.jpg", ofType: nil)!
        let path10 = Bundle.main.path(forResource: "image10.jpg", ofType: nil)!
        let path11 = Bundle.main.path(forResource: "image11.jpg", ofType: nil)!
        let path12 = Bundle.main.path(forResource: "image12.jpg", ofType: nil)!
        let path13 = Bundle.main.path(forResource: "image13.png", ofType: nil)!
        let path14 = Bundle.main.path(forResource: "image14.jpg", ofType: nil)!
        let path15 = Bundle.main.path(forResource: "image15.png", ofType: nil)!
        let path16 = Bundle.main.path(forResource: "image16.jpg", ofType: nil)!
        let path17 = Bundle.main.path(forResource: "image17.jpg", ofType: nil)!
        let path18 = Bundle.main.path(forResource: "image18.jpg", ofType: nil)!
        let path19 = Bundle.main.path(forResource: "image19.jpg", ofType: nil)!
        
        guard let image1 = UIImage(named: path1) else { return  }
        guard let image2 = UIImage(named: path2) else { return  }
        guard let image3 = UIImage(named: path3) else { return  }
        guard let image4 = UIImage(named: path4) else { return  }
        guard let image5 = UIImage(named: path5) else { return  }
        guard let image6 = UIImage(named: path6) else { return  }
        guard let image7 = UIImage(named: path7) else { return  }
        guard let image8 = UIImage(named: path8) else { return  }
        guard let image9 = UIImage(named: path9) else { return  }
        guard let image10 = UIImage(named: path10) else { return  }
        guard let image11 = UIImage(named: path11) else { return  }
        guard let image12 = UIImage(named: path12) else { return  }
        guard let image13 = UIImage(named: path13) else { return  }
        guard let image14 = UIImage(named: path14) else { return  }
        guard let image15 = UIImage(named: path15) else { return  }
        guard let image16 = UIImage(named: path16) else { return  }
        guard let image17 = UIImage(named: path17) else { return  }
        guard let image18 = UIImage(named: path18) else { return  }
        guard let image19 = UIImage(named: path19) else { return  }
        
        
        
        images.append(image1)
        images.append(image2)
        images.append(image3)
        images.append(image4)
        images.append(image5)
        images.append(image6)
        images.append(image7)
        images.append(image8)
        images.append(image9)
        images.append(image10)
        images.append(image11)
        images.append(image12)
        images.append(image13)
        images.append(image14)
        images.append(image15)
        images.append(image16)
        images.append(image17)
        images.append(image18)
        images.append(image19)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: 137, height: 185)

        return size
    }
    
    
}


