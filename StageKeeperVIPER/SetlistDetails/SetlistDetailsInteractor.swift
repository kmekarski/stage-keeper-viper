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
}
