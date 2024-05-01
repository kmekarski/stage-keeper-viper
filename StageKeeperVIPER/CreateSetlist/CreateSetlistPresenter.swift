//
//  CreateSetlistPresenter.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistPresenterProtocol {
    var view: CreateSetlistViewProtocol? { get set }
    var interactor: CreateSetlistInteractorProtocol? { get set }
    var router: CreateSetlistRouterProtocol? { get set }
    
    func viewDidLoad()
}

class CreateSetlistPresenter: CreateSetlistPresenterProtocol {
    
    var view: CreateSetlistViewProtocol?
    
    var interactor: CreateSetlistInteractorProtocol?
    
    var router: CreateSetlistRouterProtocol?
    
    func viewDidLoad() {
        
    }
}
