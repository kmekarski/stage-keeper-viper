//
//  SetlistDetailsRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol SetlistDetailsRouterProtocol {
    var entry: SetlistDetailsViewController? { get }
    var delegate: SetlistDetailsRouterDelegate? { get set }
    static func createSetlistDetails(with setlist: Setlist) -> SetlistDetailsRouterProtocol
    
    func navigateBack()
    func notifyDelegateAboutDeletingSetlist(setlist: Setlist)
}

class SetlistDetailsRouter: SetlistDetailsRouterProtocol {

    var entry: SetlistDetailsViewController?
    var delegate: SetlistDetailsRouterDelegate?

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
    
    func navigateBack() {
        guard let viewController = self.entry else { return }
        viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func notifyDelegateAboutDeletingSetlist(setlist: Setlist) {
        delegate?.didDeleteSetlist(setlist: setlist)
    }
}
