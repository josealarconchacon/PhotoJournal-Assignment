//
//  ViewController.swift
//  PhotoJournal-Assignment
//
//  Created by Jose Alarcon Chacon on 1/14/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
  
   // var  index: Int!
    var photoJournal = PhotoJournalModel.getPhotoJournal()
    private var imagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print(DataPresistenceManager.documentsDirectory())
        print(photoJournal)
        reload()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        photoJournal = PhotoJournalModel.getPhotoJournal()
    }


    @IBAction func buttonTouched(_ sender: UIButton) {
        collectionView.reloadData()
}
    @objc func alert(sender: UIButton) {
        let index = sender.tag
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (UIAlertAction) in
          print("Delete")
            PhotoJournalModel.deletPost(photo: self.photoJournal[index], index: index)
            self.collectionView.reloadData()
            self.reload()
        }
        optionMenu.addAction(deleteAction)
        let editAction = UIAlertAction(title: "Edit", style: .default) { (UIAlertAction) in
            print("Edit")
            PhotoJournalModel.editItem(photo: self.photoJournal[index], atIndex: index)
            self.reload()
        }
        optionMenu.addAction(editAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    func reload() {
        photoJournal = PhotoJournalModel.getPhotoJournal()
        collectionView.reloadData()
    }
    
    @IBAction func editButtonTouched(_ sender: UIButton) {
    
    }
}
extension PhotoJournalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoJournal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoJournalCell", for: indexPath) as? PhotoJournalCell else {return UICollectionViewCell()}
        let photoToSet = photoJournal[indexPath.row]
        cell.titleName.text = photoToSet.title
        cell.titleActualTime.text = photoToSet.dateFormattedString
        cell.imageView.image = UIImage(data: photoToSet.imageData)
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(alert), for: .touchUpInside)
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 300, height: 300)
    }
}
