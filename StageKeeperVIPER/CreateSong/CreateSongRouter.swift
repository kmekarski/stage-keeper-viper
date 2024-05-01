//
//  CreateSongRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSongRouterProtocol {
    var entry: CreateSongViewController? { get }
    static func createCreateSong(screen: CreateSongScreen?) -> CreateSongRouterProtocol
    func navigateBack()
    func navigate(to screen: CreateSongScreen, song: Song?)
}

class CreateSongRouter: CreateSongRouterProtocol {
    var entry: CreateSongViewController?

    static func createCreateSong(screen: CreateSongScreen? = nil) -> any CreateSongRouterProtocol {
        let router = CreateSongRouter()
        
        let view = CreateSongViewController(screen: screen)
        let presenter = CreateSongPresenter()
        let interactor = CreateSongInteractor()
        
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
    
    func navigate(to screen: CreateSongScreen, song: Song? = nil) {
        guard let viewController = self.entry else { return }
        let destinationVC = CreateSongViewController(screen: screen, song: song)
        destinationVC.presenter = self.entry?.presenter
        viewController.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
