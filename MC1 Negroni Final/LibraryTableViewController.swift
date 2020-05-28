//
//  LibraryTableViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 20/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    var books = [Book]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.rowHeight = UITableView.automaticDimension
        
        loadSampleBooks()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "libraryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LibraryTableViewCell
        // Configure the cell...
        
        cell.cover = books[indexPath.row].cover
        cell.titleLabel.text = books[indexPath.row].title
        cell.categoryLabel.text = books[indexPath.row].category
        cell.numberOfStepsLabel.text = "Steps needed to listen: " + String(books[indexPath.row].durationInSteps)
        
        tableView.rowHeight = 180
        

        return cell
    }
    
    func loadSampleBooks(){
        let ch1 = Chapter()
        ch1.setVals(title: "ch1", durationInMinutes: 43.0, path: "AudioBooks/DivineComedy/ch1.mp3")
        let ch2 = Chapter()
        ch2.setVals(title: "ch2", durationInMinutes: 37.0, path: "AudioBooks/DivineComedy/ch2.mp3")
        let ch3 = Chapter()
        ch3.setVals(title: "ch3", durationInMinutes: 47.0, path: "AudioBooks/DivineComedy/ch3.mp3")
        let book = Book()
        book.setVals(title: "Divine Comedy", chapterList: [ch1,ch2,ch3], cover: "AudioBooks/DivineComedy/image.jpg", category: "Poem")
        
        
        books = [book]
        
        
        
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
           selectedRow = indexPath.row
           print("selected row at \(selectedRow)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ChapterListViewController
        dest.bookImage = books[selectedRow].cover
        dest.chapterList = books[selectedRow].chapterList
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
