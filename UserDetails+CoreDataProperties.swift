//
//  UserDetails+CoreDataProperties.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//
//

import Foundation
import CoreData


extension UserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetails> {
        return NSFetchRequest<UserDetails>(entityName: "UserDetails")
    }

    @NSManaged public var totalScore: Int16
    @NSManaged public var playStatus: Bool

}

extension UserDetails : Identifiable {

}
