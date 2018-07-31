//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jacob Metcalf on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    
    var book: Book?
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTextField.text, let reasonToRead = reasonToReadTextView.text else { return }
        if let book = book {
            bookController?.updateTitleAndReasonOf(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.create(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            navigationController?.title = book.title
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
        } else {
            navigationController?.title = "Add a new book"
        }
    }
    
}
