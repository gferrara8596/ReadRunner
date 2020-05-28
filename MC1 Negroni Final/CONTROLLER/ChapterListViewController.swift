//
//  ChapterListViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 21/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//
// MARK: LIBRARIES

import UIKit



class ChapterListViewController: UIViewController {

    
    // MARK: INTERFACE BUILDER OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var bookImage: UIImageView!
    
    
    var selectedRow: Int?
    var listeningChapter: Int?
    var audioBook: AudioBook?
    var image: UIImage?
    
    @IBOutlet weak var currentChapter: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitle.text = audioBook?.title
        bookTitle.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        authorName.text = audioBook?.author
        authorName.font = UIFont(name: "SFProText-Medium", size: 18)
        currentChapter.text = "You are listening chapter ..."
        currentChapter.font = UIFont(name: "SFProCompactText-Light", size: 14)
        tableView.delegate = self
        tableView.dataSource = self
        bookImage = UIImageView(image: image)
        bookImage.frame = CGRect(x: 10, y: 100, width: 180, height: 250)
        view.addSubview(bookImage)
        roundCorners(of: bookImage, by: 15)
        authorName.font.withSize(18)
        
        
    } // END override func viewDidLoad() {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PlayerViewController
        guard let path = audioBook?.chapters?[selectedRow ?? 0].pathToAudioFile else { return  }
        let url = URL.init(fileURLWithPath: path)
        destination.url = url
        print("the url is \(url)")
        destination.audioBook = audioBook
        print("listening the chapter  \(tableView.indexPathForSelectedRow?.row)")
        destination.chapterIndex = tableView.indexPathForSelectedRow?.row
        destination.bookCoverImage = image
        
    } // END override func prepare(for segue) {}
    
    //MARK: UI FUNCTIONS

    func roundCorners(of view: UIView, by radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
} // END class ChapterListViewController {}


// MARK: EXTENSIONS
    
extension ChapterListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView ,
                   numberOfRowsInSection section: Int) -> Int {
        
        return audioBook?.chapters?.count ?? 0
    
    }
    
    
    func tableView(_ tableView: UITableView ,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "chapterCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as UITableViewCell
        
        cell.textLabel?.text = audioBook?.chapters?[indexPath.row].title
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "SFCompactText-Semibold", size: 18)
        cell.textLabel?.text = cell.textLabel?.text?.uppercased()
        cell.detailTextLabel?.text = "\(audioBook?.chapters?[indexPath.row].durationInSteps ?? 0)"
        cell.detailTextLabel?.textColor = #colorLiteral(red: 1, green: 0.8524137139, blue: 0.3276733458, alpha: 1)
        cell.detailTextLabel?.font = UIFont(name: "SFCompactText-Light", size: 18)
        
        tableView.rowHeight = 60

        return cell
    }
    
    
    func tableView(_ tableView: UITableView ,
                   didSelectRowAt indexPath: IndexPath) {
        
       selectedRow = indexPath.row
        
       print("selected row at \(selectedRow)")
    }
    
    

} // END extension ChapterListViewController
