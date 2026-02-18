//
//  Music.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

struct MusicResponse: Codable {
    let results: [Track]
}

struct Track: Codable, Identifiable {
    var id: Int { trackId } 
    let trackId: Int
    let trackName: String
    let collectionName: String
}
