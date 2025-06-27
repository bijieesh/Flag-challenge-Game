//
//  CountriesItems+CoreDataProperties.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 24/06/25.
//
//

import Foundation
import CoreData


extension CountriesItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountriesItems> {
        return NSFetchRequest<CountriesItems>(entityName: "CountriesItems")
    }

    @NSManaged public var id: Int16
    @NSManaged public var country_name: String?
    @NSManaged public var questionlist: Questions?

}

extension CountriesItems : Identifiable {

}
