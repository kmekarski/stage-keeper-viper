//
//  AuthView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation
import UIKit

enum AuthScreenType {
    case signIn
    case signUp
}

protocol AuthViewProtocol {
    var presenter: AuthPresenterProtocol? { get set }
    func getCurrentScreen() -> AuthScreenType
    func getSignInAuthData() -> SignInAuthData?
    func getSignUpAuthData() -> SignUpAuthData?
    func displayError(_ error: AuthError)
}

class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?
    var screen: AuthScreenType
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Username"
        return field
    }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Email"
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        return field
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Repeat password"
        return field
    }()
    
    private lazy var switchScreenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchScreenButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    init(screen: AuthScreenType = .signIn) {
        self.screen = screen
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    func getCurrentScreen() -> AuthScreenType {
        return screen
    }
    
    func getSignInAuthData() -> SignInAuthData? {
        guard let email = emailTextField.text,
                let password = passwordTextField.text else { return nil }
        return SignInAuthData(email: email, password: password)
    }
    
    func getSignUpAuthData() -> SignUpAuthData? {
        guard let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let repeatedPassword = repeatPasswordTextField.text else { return nil }
        return SignUpAuthData(username: username, email: email, password: password, repeatedPassword: repeatedPassword)
    }
    
    func displayError(_ error: AuthError) {
        switch error {
        case .invalidUsername:
            print("invalid username")
        case .invalidEmail:
            print("invalid email")
        case .invalidPassword:
            print("invalid password")
        case .passwordsAreNotTheSame:
            print("passwords must be equal")
        case .wrongCredentials:
            print("wrong credentials")
        case .unableToSignUp:
            print("unable to sign up")
        default:
            break
        }
    }
    
}

private extension AuthViewController {
    var padding: CGFloat {
        return 24
    }
    
    func configureUI() {
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        switch screen {
        case .signIn:
            configureSignInScreen()
        case .signUp:
            configureSignUpScreen()
        }
    }
    
    func configureSignInScreen() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(switchScreenButton)
        view.addSubview(authButton)
        
        headerLabel.text = "Sign in"
        switchScreenButton.setTitle("Don't have an account?", for: .normal)
        authButton.setTitle("Sign in", for: .normal)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 48),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            switchScreenButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 48),
            switchScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            switchScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            switchScreenButton.heightAnchor.constraint(equalToConstant: 48),
            
            authButton.topAnchor.constraint(equalTo: switchScreenButton.topAnchor, constant: 80),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            authButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func configureSignUpScreen() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(switchScreenButton)
        view.addSubview(authButton)
        
        headerLabel.text = "Sign up"
        switchScreenButton.setTitle("Already have an account?", for: .normal)
        authButton.setTitle("Sign up", for: .normal)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 48),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 48),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            switchScreenButton.topAnchor.constraint(equalTo: repeatPasswordTextField.topAnchor, constant: 48),
            switchScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            switchScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            switchScreenButton.heightAnchor.constraint(equalToConstant: 48),
            
            authButton.topAnchor.constraint(equalTo: switchScreenButton.topAnchor, constant: 80),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            authButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc
    func switchScreenButtonTapped() {
        presenter?.switchScreens()
        screen = switch screen {
        case .signIn: .signUp
        case .signUp: .signIn
        }
    }
    
    @objc
    func authButtonTapped() {
        presenter?.authenticate()
    }
}

#Preview {
    let authRouter = AuthRouter.start()
    let authVC = authRouter.entry!
    let navigation = UINavigationController()
    navigation.viewControllers = [authVC]
    return navigation
}

