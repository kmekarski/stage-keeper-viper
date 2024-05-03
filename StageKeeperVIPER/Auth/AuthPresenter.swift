//
//  AuthPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation
import FirebaseAuth

protocol AuthPresenterProtocol {
    var view: AuthViewProtocol? { get set }
    var interactor: AuthInteractorProtocol? { get set }
    var router: AuthRouterProtocol? { get set }
    
    func viewDidLoad()
    func switchScreens()
    func authenticate()
    func didAuthenticate(result: Result<User, AuthError>)
}

class AuthPresenter: AuthPresenterProtocol {
    var view: AuthViewProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
    
    
    func viewDidLoad() {
        interactor?.checkAuthentication()
    }
    
    func switchScreens() {
        guard let currentScreen = view?.getCurrentScreen() else { return }
        let destination: AuthScreenType = switch currentScreen {
        case .signIn: .signUp
        case .signUp: .signIn
        }
        router?.navigate(to: destination)
    }
    
    func authenticate() {
        guard let currentScreen = view?.getCurrentScreen() else { return }
        switch currentScreen {
        case .signIn:
            guard let signInData = view?.getSignInAuthData() else {
                view?.displayError(.unableToSignIn)
                return
            }
            interactor?.signIn(data: signInData)
        case .signUp:
            guard let signUpData = view?.getSignUpAuthData() else {
                view?.displayError(.unableToSignUp)
                return
            }
            switch validateSignUpData(signUpData) {
            case .success():
                interactor?.signUp(data: signUpData)
            case .failure(let error):
                view?.displayError(error)
            }
        }
    }
    
    func didAuthenticate(result: Result<User, AuthError>) {
        switch result {
        case .success(_):
            router?.navigateToHome()
        case .failure(let authError):
            view?.displayError(authError)
        }
    }
}



private extension AuthPresenter {
    func validateSignUpData(_ data: SignUpAuthData) -> Result<Void, AuthError> {
        if data.email == "" {
            return .failure(.invalidEmail)
        }
        if data.password != data.repeatedPassword {
            return .failure(.passwordsAreNotTheSame)
        }
        return .success(())
    }
}
