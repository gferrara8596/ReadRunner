//
//  Book.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 20/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//
// MARK: LIBRARIES

import UIKit

class Book {
    
    let bookTitle: String
    let author: String
    let bookCategory: String
    let bookCoverImage: UIImage
    let durationOfAudioFileInSeconds: Int
    let durationOfAudioFileInSteps: Int
    let pathToAudioFile: String
    
    
    init(bookTitle: String ,
         author: String ,
         bookCategory: String ,
         bookCoverImage: UIImage ,
         durationOfAudioFileInSeconds: Int ,
         durationOfAudioFileInSteps: Int ,
         pathToAudioFile: String) {
        
        self.bookTitle = bookTitle
        self.author = author
        self.bookCategory = bookCategory
        self.bookCoverImage = bookCoverImage
        self.durationOfAudioFileInSeconds = durationOfAudioFileInSeconds
        self.durationOfAudioFileInSteps = durationOfAudioFileInSteps
        self.pathToAudioFile = pathToAudioFile

    } // END init()
    
    
} // END class Book


//class Book {
//
//    var author: String
//    var bookTitle: AudioBook
//    var bookChapterList: [Chapter]?
//    var bookCoverImage: UIImageView?
//    var durationOfBookInSeconds: Int?
//    var bookCategory: String?
//
//    var durationOfBookInSteps: Int? {
//        guard let unwrappedDurationOfBookInSeconds = durationOfBookInSeconds else {
//            return nil
//        }
//
//        return unwrappedDurationOfBookInSeconds * 2
//    } // END var durationOfBookInSteps: Int? {}
//
//
//    init?(author: String ,
//          bookTitle: String ,
//          bookChapterList: [Chapter] ,
//          bookCoverImage: UIImageView ,
//          // durationOfBookInSteps: Int ,
//          bookCategory: String) {
//
//        guard
//            let unwrappedAuthor = author as? String ,
//            let unwrappedBookTitle = bookTitle as? String ,
//            let unwrappedBookChapterList = bookChapterList as? [Chapter] ,
//            let unwrappedBookCoverImage = bookCoverImage as? UIImageView ,
//            // let unwrappedDurationOfBookInSteps = durationOfBookInSteps as? Int ,
//            let unwrappedBookCategory = bookCategory as? String else {
//                return
//        } // END guard let else {}
//
//        self.bookCategory = unwrappedBookCategory
//        self.bookChapterList = bookChapterList
//        self.bookCoverImage = unwrappedBookCoverImage
//        self.bookTitle = unwrappedBookTitle
//
//    } // END init?()
//
//
//    func calculateDurationOfBookInSeconds() -> Int {
//        var totalDurationOfBookInSeconds: Int = 0
//
//        if let unwrappedBookChapterList = bookChapterList  {
//
//            for chapter in 0...(unwrappedBookChapterList.count - 1) {
//                let chapterOfBook = unwrappedBookChapterList[chapter]
//
//                totalDurationOfBookInSeconds += chapterOfBook.chapterDurationInSeconds ?? 0
//            } // END for chapter in 0... {}
//
//        } // END if let unwrappedBookChapterList {}
//
//        return totalDurationOfBookInSeconds
//    } // END func calculateDurationOfBookInSeconds(for) {}
//
//
//    func addChapterToBook(_ chapter : Chapter) -> [Chapter] {
//        bookChapterList = []
//
//        if let chapterUnwrapped = chapter {
//           bookChapterList?.append(chapterUnwrapped)
//        }
//
//        return bookChapterList
//    }
//
//
//
//} // END class Book {}
