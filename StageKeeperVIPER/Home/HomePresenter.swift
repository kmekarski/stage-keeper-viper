//
//  SetlistsListPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation

protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }

    func viewDidLoad()
    func didFetchSetlists(with result: Result<[Setlist], Error>)
    func didFetchSongs(with result: Result<[Song], Error>)
    func setlistTapped(setlist: Setlist)
    func songTapped(song: Song)
    func createSetlistTapped()
    func createSongTapped()
    func signOut()
    func didSignOut(result: Result<Void, AuthError>)
}

class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol?
    
    var interactor: HomeInteractorProtocol?
    
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchSetlists()
        interactor?.fetchSongs()
    }
    
    func didFetchSetlists(with result: Result<[Setlist], any Error>) {
        switch result {
        case .success(let setlists):
            view?.updateSetlists(with: setlists)
        case .failure(_):
            view?.updateSetlistsError()
        }
    }
    
    func didFetchSongs(with result: Result<[Song], any Error>) {
        switch result {
        case .success(let songs):
            view?.updateSongs(with: songs)
        case .failure(_):
            view?.updateSongsError()
        }
    }
    
    func setlistTapped(setlist: Setlist) {
        router?.goToSetlistDetail(setlist)
    }
    
    func songTapped(song: Song) {
        router?.goToSongDetail(song)
    }
    
    func createSetlistTapped() {
        router?.goToCreateSetlist()
    }
    
    func createSongTapped() {
        router?.goToCreateSong()
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func didSignOut(result: Result<Void, AuthError>) {
        switch result {
        case .success(_):
            router?.navigateToAuth()
        case .failure(let error):
            view?.displaySignOutError()
        }
    }
}
