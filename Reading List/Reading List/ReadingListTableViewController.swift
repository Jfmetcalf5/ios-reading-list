//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jacob Metcalf on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BooktableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    let bookController = BookController()

    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenReadOn(book: book)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
        return bookController.readBooks[indexPath.row]
        } else if indexPath.section == 1 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.books[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read"
        }
        if section == 1 {
            return "Un-Read"
        }
        return "Error"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let detailVC = segue.destination as? BookDetailViewController else { return }
            let book = bookFor(indexPath: indexPath)
            detailVC.bookController = bookController
            detailVC.book = book
        }
        if segue.identifier == "toNew" {
            guard let detailVC = segue.destination as? BookDetailViewController else { return }
            detailVC.bookController = bookController
        }
    }
}
