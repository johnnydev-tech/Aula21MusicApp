//
//  Reponse.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
