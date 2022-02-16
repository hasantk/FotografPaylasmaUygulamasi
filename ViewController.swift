//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Hasan Atık on 11.02.2022.
//

import UIKit
import Firebase
import FirebaseAuth

    class ViewController: UIViewController {

        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var sifreTextField: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()

        }

        @IBAction func girisYapButton(_ sender: Any) {
            
            if emailTextField.text != "" && sifreTextField.text != ""{
                
                Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) {
                    (AuthDataResult, error) in
                    
                    if error != nil{
                        self.hataMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Kayıt Bilgileri Hatalı veya Eksik")                  }
                    else{
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                        
                    }
                }
            }else{
                hataMesaj(titleInput: "Hata", messageInput: "Kullanıcı Adı veya Şifre Hatalı")
                
            }
        }
        
        @IBAction func kayitOlButton(_ sender: Any) {

            if emailTextField.text != "" && sifreTextField.text != ""{
                
                Auth.auth().createUser(withEmail: emailTextField.text! , password: sifreTextField.text!) {
                    (AuthDataResult , error) in
                    
                    if error != nil{
                        
                        self.hataMesaj(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Kayıt Bilgileri Hatalı veya Eksik")
                        
                    }else{
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
            }
            else{
                hataMesaj(titleInput: "Hata", messageInput: "Kullanıcı Adı ve Şifre Giriniz")
            }
            
        
        }
        
            func hataMesaj(titleInput: String , messageInput: String){
                let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
               }
        
        
        
        }


