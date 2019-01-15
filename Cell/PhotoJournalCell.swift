//
//  PhotoJournalCell.swift
//  PhotoJournal-Assignment
//
//  Created by Jose Alarcon Chacon on 1/14/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class PhotoJournalCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var titleActualTime: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
