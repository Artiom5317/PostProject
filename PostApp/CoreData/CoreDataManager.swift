//
//  CoreDataManager.swift
//  PostApp
//
//  Created by Artiom on 29.07.25.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private init() {}
    static let shared = CoreDataManager()
    
    var allPost: [CoreDataPost] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: CRUD
    func createPosts(onePost: Post) {
        let post = CoreDataPost(context: persistentContainer.viewContext)
        post.userId = Int64(onePost.userId)
        post.id = Int64(onePost.id)
        post.title = onePost.title
        post.body = onePost.body
        post.isLiked = false
        saveContext()
    }
    
    func fetchAllPosts() {
        let req = CoreDataPost.fetchRequest()
        
        do {
            self.allPost = try persistentContainer.viewContext.fetch(req)
        } catch {
            print("error")
        }
    }
    
    func deletePost(post: CoreDataPost) {
        persistentContainer.viewContext.delete(post)
        saveContext()
    }

    func deleteLikedPosts() {
        for post in allPost {
            if post.isLiked == true {
                post.isLiked = false
            }
        }
        saveContext()
    }
}
