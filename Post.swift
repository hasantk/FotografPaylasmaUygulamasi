//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Hasan Atık on 16.02.2022.
//

import Foundation

class Post{
    
    var email : String
    var yorum : String
    var gorselUrl: String
    
    init(email: String , yorum: String , gorselUrl: String){
       
        self.gorselUrl = gorselUrl
        self.yorum = yorum
        self.email = email
    }
}
