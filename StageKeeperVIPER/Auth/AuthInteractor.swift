//
//  AuthInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation

protocol AuthInteractorProtocol {
    var presenter: AuthPresenterProtocol? { get set }
    func signIn(data: SignInAuthData)
    func signUp(data: SignUpAuthData)
}

class AuthInteractor: AuthInteractorProtocol {
    var presenter: AuthPresenterProtocol?
    
    func signIn(data: SignInAuthData) {
        print("signing in", data)
    }
    
    func signUp(data: SignUpAuthData) {
        print("signing up", data)
    }
}
