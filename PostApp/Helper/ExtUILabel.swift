//
//  ExtUILabel.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import UIKit


extension UILabel {
    
    static func createLabel(font: UIFont, colour: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = colour
        label.numberOfLines = 0
        return label
    }
    
}



