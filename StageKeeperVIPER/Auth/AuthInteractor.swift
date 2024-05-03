//
//  AuthInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthInteractorProtocol {
    var presenter: AuthPresenterProtocol? { get set }
    func signIn(data: SignInAuthData)
    func signUp(data: SignUpAuthData)
    func checkAuthentication()
}

class AuthInteractor: AuthInteractorProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    let auth = Auth.auth()
    let firestore = Firestore.firestore()
    
    func checkAuthentication() {
        if let user = auth.currentUser {
            presenter?.didAuthenticate(result: .success(user))
        }
    }
    
    func signIn(data: SignInAuthData) {
        let email = data.email
        let password = data.password
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard let user = authResult?.user, error == nil else {
                self.presenter?.didAuthenticate(result: .failure(.wrongCredentials))
                return
            }
            self.presenter?.didAuthenticate(result: .success(user))
        }
    }
    
    func signUp(data: SignUpAuthData) {
        let username = data.username
        let email = data.email
        let password = data.password
        auth.createUser(withEmail: email, password: password) { [weak self ]authResult, error in
            guard let self = self else { return }
            guard let user = authResult?.user, error == nil else {
                self.presenter?.didAuthenticate(result: .failure(.unableToSignUp))
                return
            }
            self.presenter?.didAuthenticate(result: .success(user))
        }
    }
}
