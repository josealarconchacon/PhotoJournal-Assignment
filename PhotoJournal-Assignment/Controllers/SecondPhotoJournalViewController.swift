//
//  SecondPhotoJournalViewController.swift
//  PhotoJournal-Assignment
//
//  Created by Jose Alarcon Chacon on 1/14/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class SecondPhotoJournalViewController: UIViewController {
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imageViewToAdd: UIImageView!
    @IBOutlet weak var cameraButton: UIToolbar!
    
    
    private var titlePlaceHolder = "Title"
    private var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleText()
        setupImagePickerController()
        updateUI()
        imageViewToAdd.contentMode = .scaleToFill
    }
    private func setupTitleText() {
        titleTextView.delegate = self
        titleTextView.text = titlePlaceHolder
        titleTextView.textColor = .lightGray
    }
    private func updateUI() {
        if let photoJournal = PhotoJournalModel.getPhotoJournal() {
            let image = UIImage(data: photoJournal.imageData)
            imageViewToAdd.image = image
        } else {
            print("Image does not exist")
        }
    }
    private func setupImagePickerController() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isHidden = false
        }
    }
    private func showImagePickerController() {
        present(imagePickerController,animated: true,completion:  nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let textView = titleTextView.text else {
            fatalError("Title is nil")
            let date = Date()
            let isoDateFormetter = ISO8601DateFormatter()
            isoDateFormetter.formatOptions = [.withFullDate,
                                                    .withFullTime,
                                                    .withInternetDateTime,
                                                    .withTimeZone,
                                                    .withDashSeparatorInDate]
            let timestamp = isoDateFormetter.string(from: date)
        }
    }
    
    @IBAction func cameraButtonTouched(_ sender: UIBarButtonItem) {
    }
    @IBAction func photoLibraryTouched(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .photoLibrary
        showImagePickerController()
    }
    
}
extension SecondPhotoJournalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.text == titlePlaceHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
}
extension SecondPhotoJournalViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewToAdd.image = image
            
        } else {
            print("Image ia nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
