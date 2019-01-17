//
//  PhotoJournalModel.swift
//  PhotoJournal-Assignment
//
//  Created by Jose Alarcon Chacon on 1/14/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
final class PhotoJournalModel {
   private static let filename = "PhotoJournalList.plist"
  private static var photoJournal = [PhotoJournal]()
    private init() {}
    static func savePhotoJournal() {
        let path = DataPresistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error: \(error)")
        }
    }
    static func getPhotoJournal() -> [PhotoJournal] {
        let path = DataPresistenceManager.filepathToDocumentsDirectory(filename: filename).path
       
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = try FileManager.default.contents(atPath: path) {
                do {
                    photoJournal = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal() - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return photoJournal
    }
    static func addPhoto(photo: PhotoJournal) {
        photoJournal.append(photo)
        savePhotoJournal()
    }
    static func deletPost(photo: PhotoJournal, index: Int) {
        photoJournal.remove(at: index)
        savePhotoJournal()
    }
    static func editItem(photo: PhotoJournal, Index index: Int) {
        photoJournal.remove(at: index)
        photoJournal.insert(photo, at: index)
        savePhotoJournal()
    }
}
