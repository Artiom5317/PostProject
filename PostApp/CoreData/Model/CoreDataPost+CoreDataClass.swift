//
//  CoreDataPost+CoreDataClass.swift
//  PostApp
//
//  Created by Artiom on 30.07.25.
//
//

import Foundation
import CoreData

@objc(CoreDataPost)
public class CoreDataPost: NSManagedObject {

}



extension CoreDataPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPost> {
        return NSFetchRequest<CoreDataPost>(entityName: "CoreDataPost")
    }

    @NSManaged public var userId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var isLiked: Bool

}

extension CoreDataPost : Identifiable {

}
