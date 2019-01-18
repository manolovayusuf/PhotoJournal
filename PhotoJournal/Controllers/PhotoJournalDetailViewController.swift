//
//  PhotoJournalDetailViewController.swift
//  PhotoJournal
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import UIKit


class PhotoJournalDetailViewController: UIViewController {

    private var imagePickerViewController: UIImagePickerController!
    private var photoDescriptionPlaceholder = "Photo description..."
    
    @IBOutlet weak var photoDescription: UITextView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    public var imageIndex: Int?
    private var isEditingList = false
    public var currentPhoto: PhotoJournal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        setupTextView()
    }
    
    private func setupTextView() {
        photoDescription.delegate = self
        photoDescription.text = photoDescriptionPlaceholder
        photoDescription.textColor = .lightGray
    }
   
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let saveImage = photoImage.image?.jpegData(compressionQuality: 0.5),
            let photoDescrip = photoDescription.text else {
                fatalError("title, description and image are nil")
        }
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
        let timestamp = isoDateFormatter.string(from: date)
        let post = PhotoJournal.init(createdAt: timestamp, imageData: saveImage, description: photoDescrip)
        
        if let imageIndex = imageIndex, let currentPhoto = currentPhoto {
            PhotoJournalModel.update(photos: post, atIndex: imageIndex)
        } else {
            PhotoJournalModel.addPhotos(photos: post)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .photoLibrary
        showImagePickerController()
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        showImagePickerController()
    }
    
    private func showImagePickerController() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func setupImagePickerViewController() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
        
        if let photoArray = currentPhoto {
            photoImage.image = UIImage.init(data: photoArray.imageData)
        }
        
        if let photoArr = currentPhoto {
            photoDescription.text = photoArr.description
        }
    }
    
    private func savePhotoJournal(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let photoJournal = PhotoJournal.init(createdAt: "no date", imageData: imageData, description: "Dope Wallpaper")
            PhotoJournalModel.savePhotoJournal(photoJournal: photoJournal)
        }
    }
}

extension PhotoJournalDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImage.image = image
            savePhotoJournal(image: image)
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension PhotoJournalDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if photoDescription.text == photoDescriptionPlaceholder {
            photoDescription.text = ""
            photoDescription.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView == photoDescription {
                textView.text = photoDescriptionPlaceholder
                textView.textColor = .lightGray
            }
        }
    }
}

