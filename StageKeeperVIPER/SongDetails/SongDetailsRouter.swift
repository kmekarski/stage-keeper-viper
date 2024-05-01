//
//  SongDetailsRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SongDetailsRouterProtocol {
    var entry: SongDetailsViewController? { get }
    static func createSongDetails(with song: Song) -> SongDetailsRouterProtocol
}

class SongDetailsRouter: SongDetailsRouterProtocol {
    var entry: SongDetailsViewController?

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
}
