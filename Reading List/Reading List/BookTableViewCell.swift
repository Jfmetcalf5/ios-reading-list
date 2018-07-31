//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jacob Metcalf on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol BooktableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    weak var delegate: BooktableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        let image = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
        hasBeenReadButton.setImage(image, for: .normal)
    }
}
