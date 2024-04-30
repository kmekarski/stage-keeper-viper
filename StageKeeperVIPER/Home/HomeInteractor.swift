//
//  SetlistsListInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation

enum NetworkError: Error {
    case unableToFetchSetlists
    case unableToFetchSongs
}

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }

    func fetchSetlists()
    func fetchSongs()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    func fetchSetlists() {
        presenter?.interactorDidFetchSetlists(with: .success(mockSetlists))
//        presenter?.interactorDidFetchSetlists(with: .failure(NetworkError.unableToFetchSetlists))
    }
    
    func fetchSongs() {
        presenter?.interactorDidFetchSongs(with: .success(mockSongs))
//        presenter?.interactorDidFetchSongs(with: .failure(NetworkError.unableToFetchSongs))
    }
    
}
