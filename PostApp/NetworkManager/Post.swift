//
//  Modeel.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import Foundation


struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}



