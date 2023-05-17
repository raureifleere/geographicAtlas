//
//  CountryDetailsAPICaller.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import Foundation

protocol CountryDetailsAPICallerDelegate {
    func didUpdateCountry(with country: CountryListModel)
    func didFailWithError(_ error: Error)
}

struct CountryDetailsAPICaller {
    var delegate: CountryDetailsAPICallerDelegate?
    
    func fetchRequest(cca2: String) {
        let urlString = "\(Constants.Links.cca2Link)\(cca2)"
        
        guard let url = URL(string: urlString) else { fatalError("Incorrect link") }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let data = data, error == nil {
                if let country = parseJSON(data) {
                    delegate?.didUpdateCountry(with: country)
                } else {
                    delegate?.didFailWithError(error!)
                }
            }else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> CountryListModel? {
        var countryModel: CountryListModel?
        do {
            let decodedData = try JSONDecoder().decode([CountryListData].self, from: data)
            guard
                let country = decodedData.first
            else { return nil }
            
            countryModel = CountryListModel(name: country.name, cca2: country.cca2, currencies: country.currencies , capital: country.capital, subregion: country.subregion, area: country.area, population: country.population, continents: country.continents, timezones: country.timezones, capitalInfo: country.capitalInfo, maps: country.maps, flags: country.flags)
        } catch {
            print(error)
            return nil
        }
        
        return countryModel
    }
}
