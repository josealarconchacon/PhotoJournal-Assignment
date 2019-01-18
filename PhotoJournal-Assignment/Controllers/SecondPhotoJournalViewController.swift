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
    @IBOutlet weak var saveButton: UIBarButtonItem!


    private var titlePlaceHolder = "Title"
    private var imagePickerController: UIImagePickerController!
    var imageSelected: UIImage!
    var labelToSet = ""
    var index: Int!
    enum Function{
        case edit
        case save
    }
    var function: Function!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleText()
        setupImagePickerController()
        imageViewToAdd.contentMode = .scaleToFill
        titleTextView.text = labelToSet
        titleTextView.textColor = .black
        if function == .edit {
            saveButton.isEnabled = true
            imageViewToAdd.image = imageSelected
        }
    }
    private func setupTitleText() {
        titleTextView.delegate = self
        titleTextView.text = titlePlaceHolder
        titleTextView.textColor = .lightGray
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
        if let i = index {
            PhotoJournalModel.deletPost(index: i)
        }
        guard let titleText = titleTextView.text else {
            fatalError("Title is nil")}
            let date = Date()
            let isoDateFormetter = ISO8601DateFormatter()
            isoDateFormetter.formatOptions = [.withFullDate,
                                                        .withFullTime,
                                                        .withInternetDateTime,
                                                        .withTimeZone,
                                                        .withDashSeparatorInDate]
            let timetamp = isoDateFormetter.string(from: date)
            if let imageData = imageSelected.jpegData(compressionQuality: 0.5){
                let photo = PhotoJournal.init(imageData: imageData, createdAt: timetamp, title: titleText)
                PhotoJournalModel.addPhoto(photo: photo)
            }
            dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
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
            imageSelected = image
        } else {
            print("Image ia nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
