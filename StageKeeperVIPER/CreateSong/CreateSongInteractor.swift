//
//  CreateSongInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSongInteractorProtocol {
    var presenter: CreateSongPresenterProtocol? { get set }
    
    func createSong(song: Song)
}

class CreateSongInteractor: CreateSongInteractorProtocol {
    var presenter: CreateSongPresenterProtocol?
    
    func createSong(song: Song) {
        print("\(song.name) created")
        mockSongs.append(song)
        presenter?.interactorDidCreateSong(song: song)
    }
}
