//
//  DataPresistenceManager.swift
//  PhotoJournal-Assignment
//
//  Created by Jose Alarcon Chacon on 1/14/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
final class DataPresistenceManager {
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
