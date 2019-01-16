//
//  PhotoJournalModel.swift
//  PhotoJournal
//
//  Created by Manny Yusuf on 1/16/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import Foundation

final class PhotoJournalModel {
    private static let filename = "UIImage.plist"
    // making the initializer private
    private init() {}
    
    static func savePhotoJournal(photoJournal:  PhotoJournal){
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let  data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
            
        } catch {
            print("property list encoding error: \(error)")
        }
        
    }
    static func getPhotoJournal() -> PhotoJournal? {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename).path
        var photoJournal: PhotoJournal?
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photoJournal = try PropertyListDecoder().decode(PhotoJournal.self, from: data)
                } catch {
                    print("property list decoding error:\(error)")
                }
            } else {
                print("getPhotoJournal is nil")
            }
        } else {
            print("\(filename)")
        }
        
        return photoJournal
    }
    
}
