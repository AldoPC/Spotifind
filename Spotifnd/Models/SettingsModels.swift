//
//  SettingsModels.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 24/04/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
