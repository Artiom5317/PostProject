//
//  LikedViewPresenter.swift
//  PostApp
//
//  Created by Artiom on 29.07.25.
//

import Foundation

protocol LikedViewPresenterProtocol: AnyObject {
    func getLikedPosts()
    var likedPost: [CoreDataPost] { get set }
}

class LikedViewPresenter: LikedViewPresenterProtocol {
    
    weak var view: LikedViewControllerProtocol?
    var likedPost: [CoreDataPost] = []
    
    init(view: LikedViewControllerProtocol) {
        self.view = view
    }
    
    func getLikedPosts() {
        likedPost = []
        let allPost = CoreDataManager.shared.allPost
        
        for post in allPost {
            if post.isLiked == true {
                likedPost.append(post)
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.postTableView.reloadData()
        }
    }
    
//    func getLikedPosts() {
//        CoreDataManager.shared.fetchAllPosts()
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.view?.postTableView.reloadData()
//        }
//    }
    
}
