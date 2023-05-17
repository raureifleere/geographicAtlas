//
//  CountryListData.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import Foundation


struct CountryListData: Decodable {
    let name: Name
    let cca2: String
    let currencies: [String: Currencies]?
    let capital: [String]?
    let subregion: String?
    let area: Double
    let population: Double
    let continents: [String]
    let flags: Flags
    let timezones: [String]
    let maps: Maps
    let capitalInfo: CapitalInfo
}

struct Maps: Decodable {
    let openStreetMaps: String
}

struct CapitalInfo: Decodable {
    let latlng: [Double]?
}

struct Name: Decodable {
    let common: String
}

struct Currencies: Decodable {
    let code: String?
    let name: String?
    let symbol: String?
}

struct Flags: Decodable {
    let png: String
}
