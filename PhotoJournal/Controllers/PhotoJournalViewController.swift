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
    
    
    private var allJournalImages = PhotoJournalModel.getPhotoJournal(){
        didSet {
            photoJournalCollection.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoJournalCollection.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allJournalImages = PhotoJournalModel.getPhotoJournal()
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {(action) in
            PhotoJournalModel.deletePhotos(atIndex: sender.tag)
            self.allJournalImages = PhotoJournalModel.getPhotoJournal()
        })
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {(action) in
            PhotoJournalModel.editPhotos(photos: self.allJournalImages[sender.tag], atIndex: sender.tag)
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "editStoryBoard") as? PhotoJournalDetailViewController else { return }
            viewController.imageIndex = sender.tag
            viewController.photoArray = self.allJournalImages[sender.tag]
            self.present(viewController, animated: true, completion: nil)
        })
        
        let shareAction = UIAlertAction(title: "Share", style: .default, handler: {(action) in
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(shareAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
        
        
        
        
        
        
        
        
        
        
}
extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoJournalModel.getPhotoJournal().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("cell error")
        }
        
            let photoCell = allJournalImages[indexPath.row]
            cell.photoDate.text = photoCell.dateFormattedString
            cell.photoTitle.text = photoCell.description
        if let image = UIImage.init(data: photoCell.imageData) {
            cell.photoImage.image = image
        } else {
            print("Photo display error")
        }
            return cell
        }
    }
extension PhotoJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            
        } else {
            print("Original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}

