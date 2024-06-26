//
//  AuthEntity.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation

protocol AuthData {}

struct SignUpAuthData {
    let username: String
    let email: String
    let password: String
    let repeatedPassword: String
}

struct SignInAuthData {
    let email: String
    let password: String
}

enum AuthError: Error {
    case unableToSignOut
    case unableToSignUp
    case unableToSignIn
    case invalidUsername
    case invalidEmail
    case invalidPassword
    case passwordsAreNotTheSame
    case wrongCredentials
}
