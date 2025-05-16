//
//  SavedBook+CoreDataProperties.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//
//

import Foundation
import CoreData


extension SavedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBook> {
        return NSFetchRequest<SavedBook>(entityName: "SavedBook")
    }

    @NSManaged public var authors: String?
    @NSManaged public var price: Int32
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}

extension SavedBook : Identifiable {

}
