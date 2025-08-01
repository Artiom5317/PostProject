//
//  UIvcExtension.swift
//  PostApp
//
//  Created by Artiom on 01.08.25.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
