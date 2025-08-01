//
//  MainViewController.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    var postTableView: UITableView { get set }
}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    var presenter: MainViewPresenterProtocol!
    
    lazy var postTableView: UITableView = {
        $0.frame = CGRect(x: 0, y: goToLikedViewController.frame.maxY + 10, width: view.bounds.width, height: view.bounds.height - 150)
        $0.register(PostCellView.self, forCellReuseIdentifier: PostCellView.identifier)
        $0.dataSource = self
        $0.backgroundColor = .backgroundApp
        $0.separatorStyle = .none
        $0.refreshControl = refreshControl
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    lazy var goToLikedViewController = UIButton.createButton(frame: CGRect(x: 20, y: 100, width: 100, height: 45),
                                                             title: "Go to liked",
                                                             bgColor: .systemBlue
                                                             , action: UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        self.navigationController?.pushViewController(Builder.createLikedView(), animated: true)
    }))
    lazy var deleteLikedPosts = UIButton.createButton(frame: CGRect(x: view.frame.maxX - 120, y: 100, width: 100, height: 45), title: "Delete liked", bgColor: .red, action: UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        self.presenter.deleteLikedPosts()
    }))
    
    lazy var refreshControl: UIRefreshControl = {
        $0.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return $0
    }(UIRefreshControl())
    
    @objc
    func refreshData() {
        presenter.getAllPosts()
        postTableView.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getAllPosts()
        view.backgroundColor = .backgroundApp
        title = "Posts"
        view.addSubviews(postTableView, goToLikedViewController, deleteLikedPosts)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.postTableView.reloadData()
    }
    
}



extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataManager.shared.allPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCellView.identifier, for: indexPath) as! PostCellView
        let onePost = CoreDataManager.shared.allPost[indexPath.row]
        cell.selectionStyle = .none
        cell.configurateCell(onePost: onePost)
        
        let imageName = onePost.isLiked ? "heart.fill" : "heart"
        let tintColor = onePost.isLiked ? UIColor.red : UIColor.gray
        cell.likeBtn.setImage(UIImage(systemName: imageName), for: .normal)
        cell.likeBtn.tintColor = tintColor
        
        cell.onLiked = { [weak self] in
            guard let self = self else { return }
            onePost.isLiked.toggle()
            CoreDataManager.shared.saveContext()
            self.postTableView.reloadData()
        }
        return cell
    }
}
