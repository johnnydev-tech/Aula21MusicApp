import Foundation

//
//  Repository.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

class Repository {
    
    static func loadData() async -> [Result] {
        var fetchedResults: [Result] = []
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=foo+fighters&entity=song") else {
            print("Invalid URL")
            return fetchedResults
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                fetchedResults = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
        
        return fetchedResults
    }
}
