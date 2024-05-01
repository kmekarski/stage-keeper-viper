//
//  SongDetailsPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SongDetailsPresenterProtocol {
    var view: SongDetailsViewProtocol? { get set }
    var interactor: SongDetailsInteractorProtocol? { get set }
    var router: SongDetailsRouterProtocol? { get set }
    
    func interactorDidUpdateData(result: Result<Song, Error>)
    func viewDidLoad()
}

class SongDetailsPresenter: SongDetailsPresenterProtocol {
    
    var view: SongDetailsViewProtocol?
    
    var interactor: SongDetailsInteractorProtocol?
    
    var router: SongDetailsRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getSongData()
    }
    
    func interactorDidUpdateData(result: Result<Song, any Error>) {
        switch result {
        case .success(let song):
            view?.updateSong(with: song)
        case .failure(_):
            view?.updateSongError(with: "Something went wrong")
        }
    }
    
}
