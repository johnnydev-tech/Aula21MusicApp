//
//  MusicService.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//
import Foundation

protocol MusicServiceProtocol {
    func fetchTracks(for term: String) async throws -> [Track]
}

class MusicService: MusicServiceProtocol {
    func fetchTracks(for term: String) async throws -> [Track] {
        let urlString = "https://itunes.apple.com/search?term=\(term)&entity=song"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(MusicResponse.self, from: data)
        
        return decodedResponse.results
    }
}
