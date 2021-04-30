//
//  PlaylistDetailsResponse.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 28/04/21.
//

import Foundation

struct PlaylistDetailsResponse:Codable{
    let description: String
    let external_urls: [String:String]
    let id: String
    let images:[APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable{
    let items:[PlaylistItem]
}

struct PlaylistItem: Codable{
    let track: AudioTrack
}
