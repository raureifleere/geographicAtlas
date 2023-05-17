//
//  Constants.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import Foundation


struct Constants {
    
    var isExpended = false
    
    struct Identifiers {
        static let countryListTableViewCell = "countryListTableViewCell"
        static let countryDetailsTableViewCell = "countryDetailsTableViewCell"
    }
    
    struct Links {
        static let apiURL = "https://restcountries.com/v3.1/all"
        static let cca2Link = "https://restcountries.com/v3.1/alpha/"
    }
    
    enum Continents: String, CaseIterable {
        case asia = "Asia"
        case africa = "Africa"
        case europe = "Europe"
        case n_america = "North America"
        case s_america = "South America"
        case australia = "Oceania"
        case antarctica = "Antarctica"
    }
}
