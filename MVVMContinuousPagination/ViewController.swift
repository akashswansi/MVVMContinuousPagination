//
//  ViewController.swift
//  MVVMContinuousPagination
//
//  Created by Kumar, Akash on 6/29/20.
//  Copyright © 2020 Kumar, Akash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userDetailsViewModel:[UserViewModel] = []
    let identifier = "CustomTableViewCell"
    let loadingIdentfier = "LoadingCell"
    var page = 1
    var per_page = 8
    var fetchingMore = true
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),forCellReuseIdentifier: identifier)
        tableView.register(UINib(nibName: "LoadingCell", bundle: nil),forCellReuseIdentifier: loadingIdentfier)
        tableView.addSubview(refreshControl)
        self.getData(page,per_page)
    }

    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.userDetailsViewModel = []
        self.page = 1
        self.fetchingMore = true
        self.getData(page,per_page)
        refreshControl.endRefreshing()
    }
    
    func getData(_ page:Int,_ per_page:Int){
        self.fetchingMore = false
        Service.shareInstance.getAllMovieData(page: page, perPage: per_page) { (movies, error) in
            if(error==nil){
                self.userDetailsViewModel.append(contentsOf: movies?.data.map({ return UserViewModel(movie: $0) }) ?? [])
                if self.page < movies?.total_pages ?? 0 {
                    self.page += 1
                    self.fetchingMore = true
                }
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

    extension ViewController: UITableViewDelegate, UITableViewDataSource{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userDetailsViewModel.count > 0 ? userDetailsViewModel.count : 0
        }
        
         func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && self.fetchingMore {
                let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomTableViewCell
                let model = userDetailsViewModel[indexPath.row]
                if let ids = model.id {
                    cell.idLabel.text = "\(ids)"
                }
                cell.emailAddressLabel.text = model.email ?? ""
                cell.firstNameLabel.text = model.fullName ?? ""
                if let urlString = model.avatar,let imageUrl:URL = URL(string: urlString)  {
                    cell.imageProfileView?.loadImge(withUrl: imageUrl)
                }
                return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if offsetY > (contentHeight - scrollView.frame.height){
                if fetchingMore {
                    print("API Calling")
                    self.getData(page,per_page)
                    
                }
            }
        }
    }

extension UIImageView {
    func loadImge(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
