//
//  SearchResult.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 06/05/21.
//

import Foundation

enum SearchResult{
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
