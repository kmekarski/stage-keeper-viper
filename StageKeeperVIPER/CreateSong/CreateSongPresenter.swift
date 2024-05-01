//
//  CreateSongPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSongPresenterProtocol {
    var view: CreateSongViewProtocol? { get set }
    var interactor: CreateSongInteractorProtocol? { get set }
    var router: CreateSongRouterProtocol? { get set }
    
    func viewDidLoad()
    func createSong()
    func interactorDidCreateSong()
    func goToSecondScreen()
}

class CreateSongPresenter: CreateSongPresenterProtocol {
    
    var view: CreateSongViewProtocol?
    
    var interactor: CreateSongInteractorProtocol?
    
    var router: CreateSongRouterProtocol?
    

    func viewDidLoad() {
        
    }
    
    func createSong() {
        guard let song = view?.getSongData() else { 
            view?.displayError(.invalidSongData)
            return
        }
        guard song.name != "" else {
            view?.displayError(.emptySongName)
            return
        }
        
        interactor?.createSong(song: song)
    }
    
    func interactorDidCreateSong() {
        router?.navigateBack()
    }
    
    func goToSecondScreen() {
        guard let song = view?.getSongData() else {
            view?.displayError(.invalidSongData)
            return
        }
        
        guard song.name != "" else {
            view?.displayError(.emptySongName)
            return
        }
        
        router?.navigate(to: .second, song: song)
    }
}
