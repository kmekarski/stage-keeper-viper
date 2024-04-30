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
}

class HomeRouter: HomeRouterProtocol {
    var entry: HomeViewController?
    
    static func start() -> any HomeRouterProtocol {
        let router = HomeRouter()
        
        var view = HomeViewController()
        var interactor = HomeInteractor()
        var presenter = HomePresenter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter

        router.entry = view
        return router
    }
    
    func goToSetlistDetail(_ setlist: Setlist) {
        print("going to \(setlist.name) details")
    }
    
    func goToSongDetail(_ song: Song) {
        print("going to \(song.name) details")
    }
    
}
