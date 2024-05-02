//
//  SetlistDetailsInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SetlistDetailsInteractorProtocol {
    var presenter: SetlistDetailsPresenterProtocol? { get set }
    var setlist: Setlist? { get set }
    
    func getSetlistData()
    func deleteSetlist()
}

class SetlistDetailsInteractor: SetlistDetailsInteractorProtocol {
    var presenter: SetlistDetailsPresenterProtocol?

    var setlist: Setlist?
    
    func getSetlistData() {
        if let setlist = setlist {
            presenter?.interactorDidUpdateData(result: .success(setlist))
        } else {
            presenter?.interactorDidUpdateData(result: .failure(SetlistError.unableToGetSetlistDetails))
        }
    }
    
    func deleteSetlist() {
        guard let setlist = setlist else { return }
        print("deleting \(setlist.name)")
        mockSetlists.removeAll { el in
            el.name == setlist.name
        }
        presenter?.interactorDidDeleteSetlist(setlist: setlist)
    }
}
