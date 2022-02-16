//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Hasan Atık on 11.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var tableView: UITableView!
   /* var emailDizisi = [String]()
    var yorumDizisi = [String]()
    var gorselDizisi = [String]()
    */
     
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func verileriAl(){
        let fireStoreDataBase = Firestore.firestore()
        fireStoreDataBase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { (snapShot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapShot?.isEmpty != true && snapShot != nil{
                   
                /*    self.emailDizisi.removeAll(keepingCapacity: false)
                    self.gorselDizisi.removeAll(keepingCapacity: false)
                    self.yorumDizisi.removeAll(keepingCapacity: false)
                 */
                    self.postDizisi.removeAll(keepingCapacity: false)
                    for document in snapShot!.documents{
                        //let documentId = document.documentID
                        if let gorseUrl = document.get("gorselurl") as? String{
                            if let yorum = document.get("yorum") as? String{
                                if let email = document.get("email") as? String{
                                    let post = Post(email: email, yorum: yorum, gorselUrl: gorseUrl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                       
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.emailText.text = postDizisi[indexPath.row].email
        cell.postImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselUrl))
        cell.yorumText.text = postDizisi[indexPath.row].yorum
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
}
