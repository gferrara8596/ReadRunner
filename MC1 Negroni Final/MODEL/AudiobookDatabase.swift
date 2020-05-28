//
//  Audiobook.swift
//  MC1 Negroni Final
//
//  Created by Olivier Van hamme on 23/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//
// MARK: LIBARIES

import UIKit


enum AudiobookDatabase {
    case aroundTheWorldInEightyDays
    case divineComedy
    case pinocchio
    case wizardOfOz
}


extension AudiobookDatabase {
    
    var author: String {
        
        switch self {
        case .aroundTheWorldInEightyDays : return "Jules Verne"
        case .divineComedy : return "Dante"
        case .pinocchio : return "Peppe"
        case .wizardOfOz : return "Frank Baum"
        }
        
    } // END var author: String {}
    
    
    var bookTitle: String {
        
        switch self {
        case .aroundTheWorldInEightyDays : return "Around The World In Eighty Days"
        case .divineComedy : return "The Divine Comedy"
        case .pinocchio : return "Pinocchio"
        case .wizardOfOz : return "The Wizard Of Oz"
        }
        
    } // END var bookTitle: String {}
    
    
    var bookCoverImage: UIImage {
        
        switch self {
        case .aroundTheWorldInEightyDays : return #imageLiteral(resourceName: "aroundTheWorldInEightyDays.jpg")
        case .divineComedy : return #imageLiteral(resourceName: "divineComedyDante.jpg")
        case .pinocchio : return #imageLiteral(resourceName: "adventuresOfPinocchio.jpg")
        case .wizardOfOz : return #imageLiteral(resourceName: "dorothyAndTheWizardInOz")
        }
        
    } // END var bookCoverImage: UIImage {}
    
    
    var bookCategory: String {
        
        switch self {
        case .aroundTheWorldInEightyDays : return "fiction"
        case .divineComedy : return "classics"
        case .pinocchio : return "childen"
        case .wizardOfOz : return "children"
        }
        
    } // END var bookCategory: String {}
    
    
    var pathToAudioFile: String {
        
        switch self {
        case .aroundTheWorldInEightyDays : return "Resources/chapter1AroundTheWorldInEightyDays.mp3"
        case .divineComedy : return "Resources/chapter1TheDevineComedy.mp3"
        case .pinocchio : return "Resources/chapter1Pinocchio.mp3"
        case .wizardOfOz : return "Resources/chapter1DorothyAndTheWizardInOz.mp3"
        }
        
    } // END var pathToAudioFile: String {}
    
    
    var durationOfAudioFileInSeconds: Int {
        
        switch self {
        case .aroundTheWorldInEightyDays : return 618
        case .divineComedy : return 2590
        case .pinocchio : return 1200
        case .wizardOfOz : return 537
        }
        
    } // END var durationOfAudioFileInSeconds: Int {}
    
    
    var durationOfAudioFileInSteps: Int { return self.durationOfAudioFileInSeconds * 2 }
    
    
    
} // END extension AudiobookDatabase
