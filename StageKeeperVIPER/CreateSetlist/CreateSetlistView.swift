//
//  CreateSetlistView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation
import UIKit

enum CreateSetlistScreen {
    case setNameAndDescription
    case addSongsInitially
    case main
    case editSongs
    case addSongs
}

protocol CreateSetlistViewProtocol {
    var presenter: CreateSetlistPresenterProtocol? { get set }
    func getSetlistData() -> Setlist?
    func displayError(_ error: CreateSetlistError)
}

class CreateSetlistViewController: UIViewController, CreateSetlistViewProtocol {
    
    var presenter: CreateSetlistPresenterProtocol?
    var screen: CreateSetlistScreen
    var setlist: Setlist?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Name"
        return field
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var editSongsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editSongsButtonPressed), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var addSongsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSongsButtonPressed), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createSetlistButtonPressed), for: .touchUpInside)
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    init(screen: CreateSetlistScreen?, setlist: Setlist? = nil) {
        self.screen = screen ?? .setNameAndDescription
        self.setlist = setlist
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
    
    func getSetlistData() -> Setlist? {
        guard let name = nameTextField.text else { return nil }
        return Setlist(name: name)
    }
    
    func displayError(_ error: CreateSetlistError) {
        switch error {
        case .emptySetlistName:
            print("setlist name should not be empty")
        case .invalidSetlistData:
            print("something went wrong")
        }
    }
}

private extension CreateSetlistViewController {
    var padding: CGFloat {
        return 24
    }
    func configureUI() {
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
                
        switch screen {
        case .setNameAndDescription:
            configureSetNameAndDescriptionScreen()
        case .addSongsInitially:
            configureAddSongsInitiallyScreen()
        case .main:
            configureMainScreen()
        case .editSongs:
            configureEditSongsScreen()
        case .addSongs:
            configureAddSongsScreen()
        }
    }
    
    func configureSetNameAndDescriptionScreen() {
        view.addSubview(nameTextField)
        view.addSubview(nextButton)
        
        headerLabel.text = "Create setlist"
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 48),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            nextButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 48),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func configureAddSongsInitiallyScreen() {
        view.addSubview(nextButton)
        
        headerLabel.text = "Add songs"
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 48),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func configureMainScreen() {
        view.addSubview(nameLabel)
        view.addSubview(addSongsButton)
        view.addSubview(editSongsButton)
        view.addSubview(createButton)
        
        headerLabel.text = "Create setlist"
        
        nameLabel.text = setlist?.name ?? ""
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 48),
            
            addSongsButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 48),
            addSongsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addSongsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addSongsButton.heightAnchor.constraint(equalToConstant: 48),
            
            editSongsButton.topAnchor.constraint(equalTo: addSongsButton.bottomAnchor, constant: 48),
            editSongsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            editSongsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            editSongsButton.heightAnchor.constraint(equalToConstant: 48),
            
            createButton.topAnchor.constraint(equalTo: editSongsButton.bottomAnchor, constant: 48),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func configureEditSongsScreen() {
        headerLabel.text = "Edit songs"
    }
    
    func configureAddSongsScreen() {
        headerLabel.text = "Add songs"
    }
    
    @objc
    func nextButtonPressed() {
        presenter?.goToNextScreen(currentScreen: screen)
    }
    
    @objc
    func editSongsButtonPressed() {
        presenter?.goToEditSongsScreen()
    }
    
    @objc
    func addSongsButtonPressed() {
        presenter?.goToAddSongsScreen()
    }
    
    @objc
    func createSetlistButtonPressed() {
        presenter?.createSetlist()
    }
}

#Preview {
    let createSetlistRouter = CreateSetlistRouter.createCreateSetlist(screen: .setNameAndDescription)
    let createSetlistVC = createSetlistRouter.entry!
    let navigation = UINavigationController()
    navigation.viewControllers = [createSetlistVC]
    return navigation
}
