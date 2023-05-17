//
//  CountryListModel.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import Foundation

struct CountryListModel {
    let name: Name
    let cca2: String
    let currencies: [String: Currencies]?
    let capital: [String]?
    let subregion: String?
    let area: Double
    let population: Double
    let continents: [String]
    let timezones: [String]
    let capitalInfo: CapitalInfo
    let maps: Maps
    let flags: Flags
    
    var isExpanded: Bool = false
}

struct ContinentModel {
    let name: String
    var countries: [CountryListModel]
}
