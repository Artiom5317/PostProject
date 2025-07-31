//
//  Builder.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import UIKit



final class Builder {
    
    static func createMainView() -> UIViewController {
        let view = MainViewController()
        let network = NetworkManager()
        let presenter = MainViewPresenter(view: view, networkManager: network)
        view.presenter = presenter
        return view
    }
    
    static func createLikedView() -> UIViewController {
        let view = LikedViewController()
        let presenter = LikedViewPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
