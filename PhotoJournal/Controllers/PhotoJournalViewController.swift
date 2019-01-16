//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalViewController: UIViewController {
    
    
    @IBOutlet weak var photoJournalCollection: UICollectionView!
    
    private var allJournalImages = [PhotoJournal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PhotoJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
        } else {
            print("Original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
