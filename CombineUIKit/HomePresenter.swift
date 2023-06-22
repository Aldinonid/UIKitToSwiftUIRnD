// 
//  HomePresenter.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-16.
//

import Foundation

class HomePresenter {
    
    private let interactor: HomeInteractor
    private let router = HomeRouter()
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
}
