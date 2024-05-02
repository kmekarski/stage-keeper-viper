//
//  SongDetailsRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SongDetailsRouterProtocol {
    var entry: SongDetailsViewController? { get }
    var delegate: SongDetailsRouterDelegate? { get set }
    static func createSongDetails(with song: Song) -> SongDetailsRouterProtocol
    
    func navigateBack()
    func notifyDelegateAboutDeletingSong(song: Song)
}

class SongDetailsRouter: SongDetailsRouterProtocol {
    
    var entry: SongDetailsViewController?
    var delegate: SongDetailsRouterDelegate?

    static func createSongDetails(with song: Song) -> any SongDetailsRouterProtocol {
        let router = SongDetailsRouter()
        
        let view = SongDetailsViewController()
        let presenter = SongDetailsPresenter()
        let interactor = SongDetailsInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.song = song
        
        router.entry = view
        return router
    }
    
    func navigateBack() {
        guard let viewController = self.entry else { return }
        viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func notifyDelegateAboutDeletingSong(song: Song) {
        delegate?.didDeleteSong(song: song)
    }
}
