//
//  MusicServiceKey.swift
//  Aula21MusicApp
//
//  Created by Johnny Freire on 04/02/26.
//

import SwiftUI


struct MusicServiceKey: EnvironmentKey {

    static var defaultValue: MusicServiceProtocol = MusicService()
}

extension EnvironmentValues {
    var musicService: MusicServiceProtocol {
        get { self[MusicServiceKey.self] }
        set { self[MusicServiceKey.self] = newValue }
    }
}
