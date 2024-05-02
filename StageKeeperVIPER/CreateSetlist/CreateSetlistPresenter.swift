//
//  CreateSetlistPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistPresenterProtocol {
    var view: CreateSetlistViewProtocol? { get set }
    var interactor: CreateSetlistInteractorProtocol? { get set }
    var router: CreateSetlistRouterProtocol? { get set }
    
    func viewDidLoad()
    func createSetlist()
    func interactorDidCreateSetlist(setlist: Setlist)
    func goToNextScreen(currentScreen: CreateSetlistScreen)
    func goToAddSongsScreen()
    func goToEditSongsScreen()
}

class CreateSetlistPresenter: CreateSetlistPresenterProtocol {
    
    var view: CreateSetlistViewProtocol?
    
    var interactor: CreateSetlistInteractorProtocol?
    
    var router: CreateSetlistRouterProtocol?
    

    func viewDidLoad() {
        
    }
    
    func createSetlist() {
        guard let setlist = view?.getSetlistData() else {
            view?.displayError(.invalidSetlistData)
            return
        }
        guard setlist.name != "" else {
            view?.displayError(.emptySetlistName)
            return
        }
        
        interactor?.createSetlist(setlist: setlist)
    }
    
    func interactorDidCreateSetlist(setlist: Setlist) {
        router?.notifyDelegateAboutCreatingSetlist(setlist: setlist)
        router?.navigateBack()
    }
    
    func goToNextScreen(currentScreen: CreateSetlistScreen) {
        guard let setlist = view?.getSetlistData() else {
            view?.displayError(.invalidSetlistData)
            return
        }
        
        guard setlist.name != "" else {
            view?.displayError(.emptySetlistName)
            return
        }
        
        switch currentScreen {
        case .setNameAndDescription:
            router?.navigate(to: .addSongsInitially, setlist: setlist)
        case .addSongsInitially:
            router?.navigate(to: .main, setlist: setlist)
        default: break
        }
    }
    
    func goToAddSongsScreen() {
        guard let setlist = view?.getSetlistData() else {
            view?.displayError(.invalidSetlistData)
            return
        }
        router?.navigate(to: .addSongs, setlist: setlist)
    }
    func goToEditSongsScreen() {
        guard let setlist = view?.getSetlistData() else {
            view?.displayError(.invalidSetlistData)
            return
        }
        router?.navigate(to: .editSongs, setlist: setlist)
    }
}
