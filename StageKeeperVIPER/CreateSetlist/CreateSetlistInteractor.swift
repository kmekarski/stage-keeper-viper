//
//  CreateSetlistInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistInteractorProtocol {
    var presenter: CreateSetlistPresenterProtocol? { get set }
    
    func createSetlist(setlist: Setlist)
}

class CreateSetlistInteractor: CreateSetlistInteractorProtocol {
    var presenter: CreateSetlistPresenterProtocol?
    
    func createSetlist(setlist: Setlist) {
        print("\(setlist.name) created")
        mockSetlists.append(setlist)
        presenter?.interactorDidCreateSetlist(setlist: setlist)
    }
}
