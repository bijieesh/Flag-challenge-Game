//
//  File.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 24/06/25.
//

import Foundation

struct QuestionListDTO: Codable {
    let questions: [QuestionDTO]
}


struct CountryDTO: Codable {
    let id: Int
    let country_name: String
}

struct QuestionDTO: Codable {
    let answer_id: Int
    let country_code: String
    let countries: [CountryDTO]
}
