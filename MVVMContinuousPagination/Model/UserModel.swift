//
//  UserModel.swift
//  MVVMContinuousPagination
//
//  Created by Kumar, Akash on 6/29/20.
//  Copyright © 2020 Kumar, Akash. All rights reserved.
//

import UIKit

struct UserModel:Codable{
    var id: Int?
    var email: String?
    var first_name:String?
    var last_name:String?
    var avatar:String?
    init(id:Int, email: String,first_name: String,last_name: String,avatar: String){
        self.id = id
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.avatar = avatar
    }
}

struct DetailsModel: Codable{
    var page: Int?
    var per_page:Int?
    var total :Int?
    var total_pages:Int?
    var data = [UserModel]()
    init(page:Int,per_page:Int,total:Int,total_pages:Int,details: [UserModel]) {
        self.page = page
        self.per_page = per_page
        self.total = total
        self.total_pages = total_pages
        self.data = details
    }
}
