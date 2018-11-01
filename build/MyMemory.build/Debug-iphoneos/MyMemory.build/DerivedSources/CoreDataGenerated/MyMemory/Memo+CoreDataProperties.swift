//
//  Memo+CoreDataProperties.swift
//  
//
//  Created by 조영빈 on 2018. 10. 31..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var contents: String?
    @NSManaged public var title: String?

}
