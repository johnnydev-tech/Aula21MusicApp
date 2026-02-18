//
//  MusicListViewModel.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

import Foundation
import SwiftUI
import Combine

enum ViewState {
    case idle
    case loading
    case success([Track])
    case error(String)
    case empty
}

@MainActor
class MusicListViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .idle
    @Published var searchTerm: String = ""
    
    private let service: MusicServiceProtocol
    
    
    init(service: MusicServiceProtocol) {
        self.service = service
    }
    
    func loadMusic() async {
        let trimmed = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            state = .empty
            return
        }
        state = .loading
        do {
            let fetchedTracks = try await service.fetchTracks(for: trimmed)
            if fetchedTracks.isEmpty {
                state = .empty
            } else {
                state = .success(fetchedTracks)
            }
        } catch {
            state = .error("Não foi possível carregar as músicas. Verifique sua conexão.")
        }
    }
}

