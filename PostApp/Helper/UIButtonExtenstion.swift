//
//  UIButtonExtenstion.swift
//  PostApp
//
//  Created by Artiom on 01.08.25.
//

import UIKit


extension UIButton {
    
    static func createButton(frame: CGRect, title: String, bgColor: UIColor, action: UIAction) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = bgColor
        return btn
    }
    
}
