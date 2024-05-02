//
//  AuthRouter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation

protocol AuthRouterProtocol {
    var entry: AuthViewController? { get set }
    static func start(screen: AuthScreenType) -> AuthRouterProtocol
    func navigate(to screen: AuthScreenType)

}

class AuthRouter: AuthRouterProtocol {
    var entry: AuthViewController?
    
    static func start(screen: AuthScreenType = .signIn) -> AuthRouterProtocol {
        let router = AuthRouter()
        
        let view = AuthViewController(screen: screen)
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter

        router.entry = view
        return router
    }
    
    func navigate(to screen: AuthScreenType) {
        guard let viewController = self.entry else { return }
        let authRouter = AuthRouter.start(screen: screen)
        let destinationVC = authRouter.entry!
        viewController.navigationController?.setViewControllers([destinationVC], animated: true)
    }
}
