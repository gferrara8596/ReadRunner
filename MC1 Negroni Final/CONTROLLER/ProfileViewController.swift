//
//  SummaryViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 21/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit
import CoreMotion

class ProfileViewController: UIViewController {
    
    // MARK: INTERFACE BUILDER OUTLETS
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    var date: Date!
    var pedometer = CMPedometer()
    var lastWeekSteps: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("loading steps")
        loadSteps()
//        update all the labels needed
    }
    
    func loadSteps(){
        let today = Date()
        let aWeekAgo = Date(timeIntervalSince1970: (today.timeIntervalSince1970 - 604800))
        print("loading data from \(aWeekAgo) to \(today)")
        pedometer.queryPedometerData(from: aWeekAgo, to: today, withHandler: { pedometerData, error in
            if let error = error { print(error); return }
            // do something with the data
            print("handler called")
            self.lastWeekSteps = pedometerData?.numberOfSteps.intValue
            print("steps: \(self.lastWeekSteps)")
        })
        
    }

}
