//
//  LibraryAlbumsResponse.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 09/05/21.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable{
    let added_at: String
    let album: Album
}
