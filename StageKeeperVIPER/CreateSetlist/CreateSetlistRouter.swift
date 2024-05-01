//
//  CreateSetlistRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistRouterProtocol {
    var entry: CreateSetlistViewController? { get }
    static func createCreateSetlist() -> CreateSetlistRouterProtocol
}

class CreateSetlistRouter: CreateSetlistRouterProtocol {
    var entry: CreateSetlistViewController?

    static func createCreateSetlist() -> any CreateSetlistRouterProtocol {
        let router = CreateSetlistRouter()
        
        let view = CreateSetlistViewController()
        let presenter = CreateSetlistPresenter()
        let interactor = CreateSetlistInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entry = view
        return router
    }
}
