//
//  SetlistDetailsPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SetlistDetailsPresenterProtocol {
    var view: SetlistDetailsViewProtocol? { get set }
    var interactor: SetlistDetailsInteractorProtocol? { get set }
    var router: SetlistDetailsRouterProtocol? { get set }
    
    func interactorDidUpdateData(result: Result<Setlist, Error>)
    func interactorDidDeleteSetlist(setlist: Setlist)
    func viewDidLoad()
    func deleteSetlist()
}

class SetlistDetailsPresenter: SetlistDetailsPresenterProtocol {

    var view: SetlistDetailsViewProtocol?
    
    var interactor: SetlistDetailsInteractorProtocol?
    
    var router: SetlistDetailsRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getSetlistData()
    }
    
    func interactorDidUpdateData(result: Result<Setlist, any Error>) {
        switch result {
        case .success(let setlist):
            view?.updateSetlist(with: setlist)
        case .failure(_):
            view?.updateSetlistError(with: "Something went wrong")
        }
    }
    
    func deleteSetlist() {
        interactor?.deleteSetlist()
    }
    
    func interactorDidDeleteSetlist(setlist: Setlist) {
        router?.notifyDelegateAboutDeletingSetlist(setlist: setlist)
        router?.navigateBack()
    }
    
}
