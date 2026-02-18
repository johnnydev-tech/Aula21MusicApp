//
//  MusicListView.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

import SwiftUI

struct MusicListView: View {
    @Environment(\.musicService) var service
    @StateObject private var viewModel: MusicListViewModel
    
    @MainActor
    init() {
        let musicService = MusicServiceKey.defaultValue
        _viewModel = StateObject(wrappedValue: MusicListViewModel(service: musicService))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle:
                    ContentUnavailableView("Busque músicas pelo nome do artista ou da faixa", systemImage: "magnifyingglass")
                    
                case .loading:
                    ProgressView("Buscando sucessos...")
                    
                case .success(let tracks):
                    List(tracks) { track in
                        TrackRowView(track: track)
                    }
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text(message)
                            .multilineTextAlignment(.center)
                        Button("Tentar novamente") {
                            Task { await viewModel.loadMusic() }
                        }
                    }
                    .padding()
                    
                case .empty:
                    ContentUnavailableView("Nenhuma música encontrada",
                                           systemImage: "music.note.slash")
                }
            }
            .searchable(text: $viewModel.searchTerm, prompt: "Buscar músicas")
            .onSubmit(of: .search) {
                Task { await viewModel.loadMusic() }
            }
            .navigationTitle("Músicas")
        }
    }
}

struct TrackRowView: View {
    let track: Track
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(track.trackName)
                .font(.headline)
            Text(track.collectionName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MusicListView()
}
