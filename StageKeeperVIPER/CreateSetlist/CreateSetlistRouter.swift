//
//  CreateSetlistRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistRouterProtocol {
    var entry: CreateSetlistViewController? { get }
    var delegate: CreateSetlistRouterDelegate? { get set }
    static func createCreateSetlist(screen: CreateSetlistScreen) -> CreateSetlistRouterProtocol
    func navigateBack()
    func navigate(to screen: CreateSetlistScreen, setlist: Setlist?)
    func notifyDelegateAboutCreatingSetlist(setlist: Setlist)
}

class CreateSetlistRouter: CreateSetlistRouterProtocol {
    
    var entry: CreateSetlistViewController?
    var delegate: CreateSetlistRouterDelegate?

    static func createCreateSetlist(screen: CreateSetlistScreen = .setNameAndDescription) -> any CreateSetlistRouterProtocol {
        let router = CreateSetlistRouter()
        
        let view = CreateSetlistViewController(screen: screen)
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
    
    func navigateBack() {
        guard let viewController = self.entry else { return }
        viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func navigate(to screen: CreateSetlistScreen, setlist: Setlist? = nil) {
        guard let viewController = self.entry else { return }
        let destinationVC = CreateSetlistViewController(screen: screen, setlist: setlist)
        destinationVC.presenter = self.entry?.presenter
        viewController.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func notifyDelegateAboutCreatingSetlist(setlist: Setlist) {
        delegate?.didCreateSetlist(setlist: setlist)
    }
}
