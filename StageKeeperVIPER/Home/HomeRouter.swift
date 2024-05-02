//
//  SetlistsListRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    var entry: HomeViewController? { get }
    static func start() -> HomeRouterProtocol
    func goToSetlistDetail(_ setlist: Setlist)
    func goToSongDetail(_ song: Song)
    func goToCreateSetlist()
    func goToCreateSong()
}

class HomeRouter: HomeRouterProtocol {
    var entry: HomeViewController?
    
    static func start() -> any HomeRouterProtocol {
        let router = HomeRouter()
        
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter

        router.entry = view
        return router
    }
    
    func goToSetlistDetail(_ setlist: Setlist) {
        var setlistDetailsRouter = SetlistDetailsRouter.createSetlistDetails(with: setlist)
        setlistDetailsRouter.delegate = self
        guard let setlistDetailsView = setlistDetailsRouter.entry,
              let viewController = self.entry else { return }
        viewController.navigationController?.pushViewController(setlistDetailsView, animated: true)
    }
    
    func goToSongDetail(_ song: Song) {
        var songDetailsRouter = SongDetailsRouter.createSongDetails(with: song)
        songDetailsRouter.delegate = self
        guard let songDetailsView = songDetailsRouter.entry,
              let viewController = self.entry else { return }
        viewController.navigationController?.pushViewController(songDetailsView, animated: true)
    }
    
    func goToCreateSetlist() {
        var createSetlistRouter = CreateSetlistRouter.createCreateSetlist()
        createSetlistRouter.delegate = self
        guard let createSetlistView = createSetlistRouter.entry,
              let viewController = self.entry else { return }
        viewController.navigationController?.pushViewController(createSetlistView, animated: true)    }
    
    func goToCreateSong() {
        var createSongRouter = CreateSongRouter.createCreateSong()
        createSongRouter.delegate = self
        guard let createSongView = createSongRouter.entry,
              let viewController = self.entry else { return }
        viewController.navigationController?.pushViewController(createSongView, animated: true)
    }
}

extension HomeRouter: CreateSetlistRouterDelegate {
    func didCreateSetlist(setlist: Setlist) {
        entry?.didCreateSetlist(setlist: setlist)
    }
}


extension HomeRouter: CreateSongRouterDelegate {
    func didCreateSong(song: Song) {
        entry?.didCreateSong(song: song)
    }
}

extension HomeRouter: SongDetailsRouterDelegate {
    func didDeleteSong(song: Song) {
        entry?.didDeleteSong(song: song)
    }
}

extension HomeRouter: SetlistDetailsRouterDelegate {
    func didDeleteSetlist(setlist: Setlist) {
        entry?.didDeleteSetlist(setlist: setlist)
    }
}
