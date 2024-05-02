//
//  SongDetailsInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SongDetailsInteractorProtocol {
    var presenter: SongDetailsPresenterProtocol? { get set }
    var song: Song? { get set }
    
    func getSongData()
    func deleteSong()
}

class SongDetailsInteractor: SongDetailsInteractorProtocol {
    
    var presenter: SongDetailsPresenterProtocol?

    var song: Song?
    
    func getSongData() {
        if let song = song {
            presenter?.interactorDidUpdateData(result: .success(song))
        } else {
            presenter?.interactorDidUpdateData(result: .failure(SongError.unableToGetSongDetails))
        }
    }
    
    func deleteSong() {
        guard let song = song else { return }
        print("deleting \(song.name)")
        mockSongs.removeAll { el in
            el.name == song.name
        }
        presenter?.interactorDidDeleteSong(song: song)
    }
}
