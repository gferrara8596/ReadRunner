//
//  Chapter.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 20/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class Chapter: NSObject {
    
    var title: String?
    var pathToAudioFile: String?
    var durationInSeconds: Int?
    var durationInSteps: Int {return (durationInSeconds ?? 0) * 2}
    
    init(title: String, pathToAudioFile: String, durationInSeconds: Int) {
        self.title = title
        self.pathToAudioFile = pathToAudioFile
        self.durationInSeconds = durationInSeconds
    }
    
}
