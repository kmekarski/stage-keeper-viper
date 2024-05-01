//
//  SetlistDetailsRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SetlistDetailsRouterProtocol {
    var entry: SetlistDetailsViewController? { get }
    static func createSetlistDetails(with setlist: Setlist) -> SetlistDetailsRouterProtocol
}

class SetlistDetailsRouter: SetlistDetailsRouterProtocol {
    var entry: SetlistDetailsViewController?
    
    static func createSetlistDetails(with setlist: Setlist) -> any SetlistDetailsRouterProtocol {
        let router = SetlistDetailsRouter()
        
        let view = SetlistDetailsViewController()
        let presenter = SetlistDetailsPresenter()
        let interactor = SetlistDetailsInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.setlist = setlist
        
        router.entry = view
        return router
    }
}
