//
//  LibraryViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 21/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//
// MARK: LIBRARIES

import UIKit


class LibraryViewController: UIViewController {
    
    // OLIVIER : I have changed the name of the books Array to the more descriptive audiobookArray ,
//    var audiobookArray: [Book] = []
    
    var selectedRow: Int = 0
    var audioBooks = [AudioBook]()

//
//
//    // MARK: INSTANCES FROM THE BOOK CLASS
//    // OLIVIER : Peppe , I have moved the creation of the books outside of the loadLibraryWithAudiobooks() helper method .
//    // This might be helpful for passing the books around between the different classes ?
//
//    let audiobookAroundTheWorldInEightyDays =
//        Book(bookTitle: AudiobookDatabase.aroundTheWorldInEightyDays.bookTitle ,
//             author: AudiobookDatabase.aroundTheWorldInEightyDays.author ,
//             bookCategory: AudiobookDatabase.aroundTheWorldInEightyDays.bookCategory ,
//             bookCoverImage: AudiobookDatabase.aroundTheWorldInEightyDays.bookCoverImage ,
//             durationOfAudioFileInSeconds: AudiobookDatabase.aroundTheWorldInEightyDays.durationOfAudioFileInSeconds ,
//             durationOfAudioFileInSteps: AudiobookDatabase.aroundTheWorldInEightyDays.durationOfAudioFileInSteps ,
//             pathToAudioFile: AudiobookDatabase.aroundTheWorldInEightyDays.pathToAudioFile)
//
//
//    let audiobookDivineComedy =
//        Book(bookTitle: AudiobookDatabase.divineComedy.bookTitle ,
//             author: AudiobookDatabase.divineComedy.author ,
//             bookCategory: AudiobookDatabase.divineComedy.bookCategory ,
//             bookCoverImage: AudiobookDatabase.divineComedy.bookCoverImage ,
//             durationOfAudioFileInSeconds: AudiobookDatabase.divineComedy.durationOfAudioFileInSeconds ,
//             durationOfAudioFileInSteps: AudiobookDatabase.divineComedy.durationOfAudioFileInSteps ,
//             pathToAudioFile: AudiobookDatabase.divineComedy.pathToAudioFile)
//
//
//    let audiobookPinocchio =
//        Book(bookTitle: AudiobookDatabase.pinocchio.bookTitle ,
//             author: AudiobookDatabase.pinocchio.author ,
//             bookCategory: AudiobookDatabase.pinocchio.bookCategory ,
//             bookCoverImage: AudiobookDatabase.pinocchio.bookCoverImage ,
//             durationOfAudioFileInSeconds: AudiobookDatabase.pinocchio.durationOfAudioFileInSeconds ,
//             durationOfAudioFileInSteps: AudiobookDatabase.pinocchio.durationOfAudioFileInSteps ,
//             pathToAudioFile: AudiobookDatabase.pinocchio.pathToAudioFile)
//
//    let audiobookWizardOfOz =
//        Book(bookTitle: AudiobookDatabase.wizardOfOz.bookTitle ,
//             author: AudiobookDatabase.wizardOfOz.author ,
//             bookCategory: AudiobookDatabase.wizardOfOz.bookCategory ,
//             bookCoverImage: AudiobookDatabase.wizardOfOz.bookCoverImage ,
//             durationOfAudioFileInSeconds: AudiobookDatabase.wizardOfOz.durationOfAudioFileInSeconds ,
//             durationOfAudioFileInSteps: AudiobookDatabase.wizardOfOz.durationOfAudioFileInSteps,
//             pathToAudioFile: AudiobookDatabase.wizardOfOz.pathToAudioFile)
//
//
//
    // MARK: INTERFACE BUILDER OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryContainerView: UIView!
    @IBOutlet weak var summaryStackView: UIStackView!
    @IBOutlet weak var weekStreakStackView: UIStackView!
    
    @IBOutlet weak var remainingStepsInChapterProgress: UIProgressView!
    var segmentedControl: UISegmentedControl!
    
    
    // MARK: METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadLibraryWithAudiobooks()
        loadBooks()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        initSegmentedControlInTitle()
        determineViewToShowAtStart()
        
        for activityView in summaryStackView.arrangedSubviews {
            roundCorners(of: activityView, by: CGFloat(8))
        }
        
        remainingStepsInChapterProgress.layer.cornerRadius = 5
        remainingStepsInChapterProgress.clipsToBounds = true
        
        remainingStepsInChapterProgress.layer.sublayers![1].cornerRadius = 5
        remainingStepsInChapterProgress.subviews[1].clipsToBounds = true
        
        for dayView in weekStreakStackView.arrangedSubviews {
            roundCorners(of: dayView, by: dayView.frame.width/2)
        }
    }
    
    
//    func loadLibraryWithAudiobooks() -> [Book] {
//
//        audiobookArray.append(audiobookAroundTheWorldInEightyDays)
//        audiobookArray.append(audiobookDivineComedy)
//        audiobookArray.append(audiobookPinocchio)
//        audiobookArray.append(audiobookWizardOfOz)
//
//        return audiobookArray
//
//        // books = [book]
//
//    } // END  loadLibraryWithAudiobooks() {}
    
    func loadBooks(){
        let pinocchioCh1Path = Bundle.main.path(forResource: "chapter1Pinocchio.mp3", ofType: nil)!
        let ch = Chapter(title: "Chapter 1", pathToAudioFile: pinocchioCh1Path, durationInSeconds: 1195)
        let pinocchioImage = UIImage(named: "adventuresOfPinocchio.jpg")!
        let book = AudioBook(title: "Adventures of Pinocchio", category: "Kids", author: "Carlo Collodi", chapters: [ch], image: pinocchioImage)
        
        let aroundTheWorldImage = UIImage(named: "aroundTheWorldInEightyDays.jpg")!
        let pathAroundCh1 = Bundle.main.path(forResource: "chapter1AroundTheWorldInEightyDays.mp3", ofType: nil)!
        let ch1 = Chapter(title: "Chapter 1", pathToAudioFile: pathAroundCh1, durationInSeconds: 617)
        let book2 = AudioBook(title: "Around The World in 80 Days", category: "Comedy", author: "Jules Verne", chapters: [ch1], image: aroundTheWorldImage)
        
        
        let divineComedyImage = UIImage(named: "divineComedyDante.jpg")!
        let pathDanteCh1 = Bundle.main.path(forResource: "chapter1TheDevineComedy.mp3", ofType: nil)!
        let pathDanteCh2 = Bundle.main.path(forResource: "chapter2TheDevineComedy.mp3", ofType: nil)!
        let pathDanteCh3 = Bundle.main.path(forResource: "chapter3TheDevineComedy.mp3", ofType: nil)!
        let ch1Dante = Chapter(title: "Chapter 1", pathToAudioFile: pathDanteCh1, durationInSeconds: 2590)
        let ch2Dante = Chapter(title: "Chapter 2", pathToAudioFile: pathDanteCh2, durationInSeconds: 2200)
        let ch3Dante = Chapter(title: "Chapter 3", pathToAudioFile: pathDanteCh3, durationInSeconds: 2824)
        let book3 = AudioBook(title: "The Divine Comedy", category: "Poem", author: "Dante Alighieri", chapters: [ch1Dante,ch2Dante,ch3Dante], image: divineComedyImage)
        
        let wizardOzImage = UIImage(named: "dorothyAndTheWizardInOz.jpg")!
        let pathOzCh1 = Bundle.main.path(forResource: "chapter1DorothyAndTheWizardInOz.mp3", ofType: nil)!
        let ch1Oz = Chapter(title: "Chapter 1", pathToAudioFile: pathOzCh1, durationInSeconds: 536)
        let book4 = AudioBook(title: "Dorothy and the Wizard in Oz", category: "Kids", author: "James Baum", chapters: [ch1Oz], image: wizardOzImage)
        
        
        audioBooks.append(book)
        audioBooks.append(book2)
        audioBooks.append(book3)
        audioBooks.append(book4)
        
    }
    
    //MARK: INTERFACE SETUP FUNCTIONS
    
    func initSegmentedControlInTitle() {
        let segmentTextContent = [
            NSLocalizedString("Library", comment: ""),
            NSLocalizedString("Summary", comment: ""),
        ]
        //var textContent: [String] = ["Library", "Summary"]
        
        segmentedControl = UISegmentedControl(items: segmentTextContent)
        // Segmented control as the custom title view.
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.autoresizingMask = .flexibleWidth
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 143, height: 30)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    func determineViewToShowAtStart() {
        if segmentedControl.selectedSegmentIndex == 0 {
            summaryContainerView.isHidden = true
            tableView.isHidden = false
        } else {
            summaryContainerView.isHidden = false
            tableView.isHidden = true
        }
        
    }
    
    func roundCorners(of view: UIView, by radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    @IBAction func segmentChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            summaryContainerView.isHidden = true
            tableView.isHidden = false
            print("Library is shown")
            break
        case 1:
            summaryContainerView.isHidden = false
            tableView.isHidden = true
            print("Summary information is shown")
            break
        default:
            break
        }
        print("CustomTitleViewController IBAction invoked!")
    }
    
    //END INTERFACE SETUP FUNCTIONS
    
    
    override func prepare(for segue: UIStoryboardSegue ,
                          sender: Any?) {

        if segue.identifier == "libraryChapterSegue" {

            let destination = segue.destination as! ChapterListViewController
            print("calling chapter of book at index \(tableView.indexPathForSelectedRow?.row)")
            destination.audioBook = self.audioBooks[tableView.indexPathForSelectedRow!.row]
            destination.image = self.audioBooks[tableView.indexPathForSelectedRow!.row].illustration

        } // END if segue.identifier == "libraryChapterSegue" {}

    } // END override func prepare(for segue) {}
    
    
    
} // END class LibraryViewController() {}



// MARK: EXTENSIONS

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView ,
                   numberOfRowsInSection section: Int) -> Int {
        return audioBooks.count
    }
    
    
    func tableView(_ tableView: UITableView ,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "libCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! LibraryTableViewCell
        
        cell.authorNameLabel.text = audioBooks[indexPath.row].author
        cell.authorNameLabel.font = UIFont(name: "SFProText-Medium", size: 18)
        cell.bookCoverImage = UIImageView(image: audioBooks[indexPath.row].illustration)
        roundCorners(of: cell.bookCoverImage, by: CGFloat(15))
        cell.bookTitleLabel.text = audioBooks[indexPath.row].title
        cell.bookTitleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        cell.currentChapterLabel.font = UIFont(name: "SFCompactText-Light", size: 14)
        cell.percentCompleteLabel.font = UIFont(name: "SFCompactText-Semibold", size: 14)
//        cell.bookCoverImage.image = audioBooks[indexPath.row].illustration
        cell.addImage()
        
        
        tableView.rowHeight = 181
        
        return cell;
    } // END func tableView(cellForRowAt) {}
    
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        selectedRow = indexPath.row
        print("selected row at \(selectedRow)")
    }
    
    
    
} // END extension LibraryViewController
