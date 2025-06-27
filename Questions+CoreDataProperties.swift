//
//  Questions+CoreDataProperties.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var answer_id: Int16
    @NSManaged public var country_code: String?
    @NSManaged public var country_flag: String?
    @NSManaged public var selectionStatus: Bool
    @NSManaged public var userAnser_id: Int16
    @NSManaged public var score: Int16
    @NSManaged public var viewStatus: Bool
    @NSManaged public var countrylist: NSSet?

}

// MARK: Generated accessors for countrylist
extension Questions {

    @objc(addCountrylistObject:)
    @NSManaged public func addToCountrylist(_ value: CountriesItems)

    @objc(removeCountrylistObject:)
    @NSManaged public func removeFromCountrylist(_ value: CountriesItems)

    @objc(addCountrylist:)
    @NSManaged public func addToCountrylist(_ values: NSSet)

    @objc(removeCountrylist:)
    @NSManaged public func removeFromCountrylist(_ values: NSSet)

}

extension Questions : Identifiable {

}
