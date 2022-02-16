//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Hasan Atık on 11.02.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumYapTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
      
    }
    
    @objc func gorselSec(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]){
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func paylasButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) {
                (storageMetadata, error) in
                if error != nil {
                    self.hataMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldın")
                }else{
                    imageReference.downloadURL {
                        (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl {
                                
                                let firestoreDataBase = Firestore.firestore()
                                
                                let firestorePost = ["gorselurl" : imageUrl, "yorum" : self.yorumYapTextField.text!,"email" : Auth.auth().currentUser!.email ,"tarih" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                firestoreDataBase.collection("Post").addDocument(data: firestorePost){
                                    (error) in
                                    if error != nil {
                                        self.hataMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyiniz")
                                    }else{
                                        self.imageView.image = UIImage(named: "gorselSec")
                                        self.yorumYapTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    func hataMesaj(titleInput: String , messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
       }

}
