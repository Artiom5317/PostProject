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
        $0.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height - 150)
        $0.register(PostCellView.self, forCellReuseIdentifier: PostCellView.identifier)
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.refreshControl = refreshControl
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    lazy var goToLikedViewController: UIButton = {
        $0.frame = CGRect(x: 20, y: 100, width: 100, height: 50)
        $0.setTitle( "Go to liked", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .systemBlue
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        self.navigationController?.pushViewController(Builder.createLikedView(), animated: true)
    })))
    
    lazy var deleteLikedPosts: UIButton = {
        $0.frame = CGRect(x: view.frame.maxX - 120, y: 100, width: 100, height: 50)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.setTitle("Delete liked", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .red
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        self.presenter.deleteLikedPosts()
    })))
    
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
        view.addSubview(postTableView)
        view.addSubview(goToLikedViewController)
        view.addSubview(deleteLikedPosts)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
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


