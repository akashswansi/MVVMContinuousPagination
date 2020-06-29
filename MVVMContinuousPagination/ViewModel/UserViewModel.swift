//
//  UserViewModel.swift
//  MVVMContinuousPagination
//
//  Created by Kumar, Akash on 6/29/20.
//  Copyright © 2020 Kumar, Akash. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {

    var id: Int?
    var email: String?
    var first_name:String?
    var last_name:String?
    var avatar:String?
    var fullName:String?
    
    init(movie:UserModel){
        self.id = movie.id
        self.email = movie.email
        self.first_name = movie.first_name
        self.last_name = movie.last_name
        self.avatar = movie.avatar
        if let firstName = first_name, let lastName = last_name{
        self.fullName = "\(firstName) \(lastName)"
        }
        else{
            self.fullName = first_name
        }
    }
    
}
