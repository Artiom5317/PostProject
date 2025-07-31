//
//  NetworkManager.swift
//  PostApp
//
//  Created by Artiom on 28.07.25.
//

import Foundation


protocol NetworkManagerProtocol: AnyObject {
    func sendReqeust(completion: @escaping ([Post]) -> ())
}


class NetworkManager: NetworkManagerProtocol {
    
    let api: String = "https://jsonplaceholder.typicode.com/posts"
    
    func sendReqeust(completion: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: api) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error  == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data else {
                print("no data")
                return }
            
            do {
                let result = try JSONDecoder().decode([Post].self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        .resume()
    }
    
}
