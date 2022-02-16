//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Hasan Atık on 11.02.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func cikisYapButton(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        }catch{
            print("Hata")
        }
        
    }
    
}
