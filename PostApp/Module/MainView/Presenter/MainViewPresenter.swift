//
//  MainViewPresenter.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import Foundation


protocol MainViewPresenterProtocol: AnyObject {
    func getAllPosts()
    func deleteLikedPosts()
    
}

class MainViewPresenter: MainViewPresenterProtocol {
    weak var view: MainViewControllerProtocol?
    var networkManager: NetworkManagerProtocol
    
    init(view: MainViewControllerProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
//    func getAllPosts() {
//        networkManager.sendReqeust { [weak self] posts in
//            guard let self = self else { return }
//            CoreDataManager.shared.fetchAllPosts()
//            if CoreDataManager.shared.allPost.count == 0 {
//
//                for post in posts {
//                    CoreDataManager.shared.createPosts(onePost: post)
//                }
//            }
//            CoreDataManager.shared.fetchAllPosts()
//            DispatchQueue.main.async {
//                self.view?.postTableView.reloadData()
//            }
//        }
//    }
    
    func getAllPosts() {
        CoreDataManager.shared.fetchAllPosts()
        if CoreDataManager.shared.allPost.count == 0 {
            networkManager.sendReqeust { [weak self] posts in
                guard let self = self else { return }
                for post in posts {
                    CoreDataManager.shared.createPosts(onePost: post)
                }
                CoreDataManager.shared.fetchAllPosts()
                DispatchQueue.main.async {
                    self.view?.postTableView.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view?.postTableView.reloadData()
            }
        }
    }
    
    
    func deleteLikedPosts() {
        CoreDataManager.shared.deleteLikedPosts()
        self.view?.postTableView.reloadData()
    }
    
}




//    func getAllPosts() {
//        networkManager.sendReqeust { [weak self] posts in
//            guard let self = self else { return }
//            self.allPosts = posts
//            DispatchQueue.main.async {
//                self.view?.postTableView.reloadData()
//            }
//        }
//    }
