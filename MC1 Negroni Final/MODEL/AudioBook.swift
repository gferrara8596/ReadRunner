//
//  AudioBook.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 23/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class AudioBook: NSObject {
    var title: String?
    var category: String?
    var author: String?
    var chapters: [Chapter]?
    var illustration: UIImage?
    var durationInSeconds: Int = 0
    var durationInSteps: Int = 0

    init(title: String, category: String, author: String, chapters: [Chapter], image: UIImage) {
        self.title = title
        self.category = category
        self.author = author
        self.chapters = chapters
        self.illustration = image
        
        for i in 0...chapters.count-1 {
            self.durationInSeconds += chapters[i].durationInSeconds ?? 0
            self.durationInSteps += chapters[i].durationInSteps
        }
        
    }
    
}
