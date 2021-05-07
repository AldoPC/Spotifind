//
//  SearchResultResponse.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 06/05/21.
//

import Foundation

struct SearchResultResponse: Codable{
    let albums: SearchAlbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistResponse
    let tracks: SearchTracksResponse
}

struct SearchAlbumResponse: Codable{
    let items: [Album]
}

struct SearchPlaylistResponse: Codable{
    let items: [Playlist]
}

struct SearchArtistsResponse: Codable{
    let items: [Artist]
}

struct SearchTracksResponse: Codable{
    let items: [AudioTrack]
}
