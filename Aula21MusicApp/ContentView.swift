//
//  ContentView.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            results = await Repository.loadData()
        }
    }
}

#Preview {
    ContentView()
}
