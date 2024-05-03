//
//  SetlistsListEntity.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation

enum NetworkError: Error {
    case unableToFetchSetlists
    case unableToFetchSongs
}

struct Setlist {
    let name: String
}

struct Song {
    let name: String
}
