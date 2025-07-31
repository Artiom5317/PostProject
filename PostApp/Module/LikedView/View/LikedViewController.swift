//
//  LikedViewController.swift
//  PostApp
//
//  Created by Artiom on 29.07.25.
//

import UIKit

protocol LikedViewControllerProtocol: AnyObject {
    var postTableView: UITableView { get set }
}

class LikedViewController: UIViewController, LikedViewControllerProtocol {
    
    var presenter: LikedViewPresenterProtocol!
    
    lazy var postTableView: UITableView = {
        $0.register(PostCellView.self, forCellReuseIdentifier: PostCellView.identifier)
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: view.frame, style: .plain))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postTableView)
        presenter.getLikedPosts()
    }
    
}


extension LikedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.likedPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCellView.identifier, for: indexPath) as! PostCellView
        let onePost = presenter.likedPost[indexPath.row]
        cell.configurateCell(onePost: onePost)
        cell.likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.likeBtn.tintColor = .red
        
        cell.onLiked = { [weak self] in
            guard let self = self else { return }
            onePost.isLiked.toggle()
            CoreDataManager.shared.saveContext()
            presenter.getLikedPosts()
        }
        
        return cell
    }
}
