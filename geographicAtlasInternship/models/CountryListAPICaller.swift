//
//  APICaller.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import Foundation

protocol CountryListAPICallerDelegate {
    func didUpdateCountryList(with countryList: [CountryListModel])
    func didFailWithError(_ error: Error)
}

struct CountryListAPICaller {
    
    var delegate: CountryListAPICallerDelegate?
    
    func fetchRequest() {
        let urlString = Constants.Links.apiURL
        
        guard let url = URL(string: urlString) else { fatalError("Incorrect link") }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let data = data, error == nil {
                if let countryList = parseJSON(data) {
                    delegate?.didUpdateCountryList(with: countryList)
                } else {
                    delegate?.didFailWithError(error!)
                }
            }else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [CountryListModel]? {
        var countryList: [CountryListModel] = []
        do {
            let decodedData = try JSONDecoder().decode([CountryListData].self, from: data)
            for country in decodedData {
                let countryModel = CountryListModel(name: country.name, cca2: country.cca2, currencies: country.currencies , capital: country.capital, subregion: country.subregion, area: country.area, population: country.population, continents: country.continents, timezones: country.timezones, capitalInfo: country.capitalInfo, maps: country.maps, flags: country.flags)
                countryList.append(countryModel)
            }
        } catch {
            print(error)
            return nil
        }
        
        return countryList
    }
}
