//
//  Service.swift
//  MVVMContinuousPagination
//
//  Created by Kumar, Akash on 6/29/20.
//  Copyright © 2020 Kumar, Akash. All rights reserved.
//

import UIKit

class Service: NSObject {

     static let shareInstance = Service()
        
        func getAllMovieData(page:Int,perPage:Int,completion: @escaping(DetailsModel?, Error?) -> ()){
            let urlString = "https://reqres.in/api/users?page=\(page)&per_page=\(perPage)"
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error{
                    completion(nil,err)
                    print("Loading data error: \(err.localizedDescription)")
                }else{
                    guard let data = data else { return }
                    do{
                        let response = try JSONDecoder().decode(DetailsModel.self, from: data)
                        
                        completion(response, nil)
                    }catch let jsonErr{
                        print("json error : \(jsonErr.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        
}
