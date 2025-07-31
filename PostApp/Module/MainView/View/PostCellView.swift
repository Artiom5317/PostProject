//
//  PostCellView.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import UIKit


final class PostCellView: UITableViewCell {
    
    static let identifier: String = "PostCellView"
    
    var onLiked: (() -> Void)?
    
    lazy var title: UILabel = UILabel.createLabel(font: .systemFont(ofSize: 12, weight: .thin), colour: .black)
    
    lazy var body: UILabel = UILabel.createLabel(font: .systemFont(ofSize: 20, weight: .light), colour: .black)
    
    lazy var profileImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var likeBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .gray
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.layer.cornerRadius = 15
        return $0
    }(UIButton(primaryAction: likeAction))
    

    lazy var likeAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.onLiked?()
    }

    lazy var customUI: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.4
        $0.layer.borderColor = UIColor.gray.cgColor
        
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.addSubview(title)
        $0.addSubview(body)
        $0.addSubview(profileImage)
        $0.addSubview(likeBtn)
        return $0
    }(UIView())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customUI)
        setupConstaints()
    }
    
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            customUI.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            customUI.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customUI.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customUI.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            profileImage.topAnchor.constraint(equalTo: customUI.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: customUI.leadingAnchor, constant: 10),
            
            
            title.topAnchor.constraint(equalTo: customUI.topAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: customUI.trailingAnchor, constant: -50),
            
            body.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            body.leadingAnchor.constraint(equalTo: customUI.leadingAnchor, constant: 15),
            body.trailingAnchor.constraint(equalTo: customUI.trailingAnchor, constant: -10),
            body.bottomAnchor.constraint(equalTo: customUI.bottomAnchor, constant: -10),
            
            likeBtn.topAnchor.constraint(equalTo: customUI.topAnchor, constant: 10),
            likeBtn.trailingAnchor.constraint(equalTo: customUI.trailingAnchor, constant: -10)
        ])
    }
    
    func configurateCell(onePost: CoreDataPost) {
        title.text = onePost.title
        body.text = onePost.body
        if let url = URL(string: "https://picsum.photos/seed/\(onePost.userId)/50/50") {
            profileImage.load(url: url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
