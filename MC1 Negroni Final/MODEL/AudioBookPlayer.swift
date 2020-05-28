//
//  AudioBook.swift
//  MC1 Negroni Final
//
//  Created by Olivier Van hamme on 22/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//
/* MARK: AUTHOR
 Olivier
*/

// MARK: LIBRARY

import UIKit
import AVFoundation



struct AudioBookPlayer {
    
    var illustration: UIImage?
    var title: String?
    var path: String?
    var url: URL?
    var audioTrack: AVAudioPlayer?
    
    init?(illustration: UIImage ,
          title: String ,
          path: String ,
          url: URL ,
          audioTrack: AVAudioPlayer) throws {
        
        guard let unwrappedIllustration = illustration as? UIImage ,
            let unwrappedTitle = title as? String ,
            let unwrappedPath = path as? String ,
            let unwrappedURL = url as? URL ,
            let unwrappedAudioTrack = audioTrack as? AVAudioPlayer else {
                
                throw AudioPlayerError.selectBookFirst
                
        } // END guard let unwrappedPath , unwrappedURL else {}
        
        self.illustration = unwrappedIllustration
        self.title = unwrappedTitle
        self.path = unwrappedPath
        self.url = unwrappedURL
        self.audioTrack = unwrappedAudioTrack
   
    } //END init()
    
    
    
} // END struct AudioBookPlayer
