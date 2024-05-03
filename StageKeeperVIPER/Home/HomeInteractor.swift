//
//  SetlistsListInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation
import FirebaseAuth

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }

    func fetchSetlists()
    func fetchSongs()
    
    func signOut()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    let auth = Auth.auth()
    
    func fetchSetlists() {
        presenter?.didFetchSetlists(with: .success(mockSetlists))
//        presenter?.interactorDidFetchSetlists(with: .failure(NetworkError.unableToFetchSetlists))
    }
    
    func fetchSongs() {
        presenter?.didFetchSongs(with: .success(mockSongs))
//        presenter?.interactorDidFetchSongs(with: .failure(NetworkError.unableToFetchSongs))
    }
    
    func signOut() {
        do {
            try auth.signOut()
            presenter?.didSignOut(result: .success(()))
        } catch {
            presenter?.didSignOut(result: .failure(.unableToSignOut))
        }
    }
    
}
