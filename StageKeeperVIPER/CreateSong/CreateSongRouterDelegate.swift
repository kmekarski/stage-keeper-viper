//
//  CreateSongRouterDelegate.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation

protocol CreateSongRouterDelegate: AnyObject {
    func didCreateSong(song: Song)
}
