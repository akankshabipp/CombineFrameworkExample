//
//  HomeViewModel.swift
//  CombineFrameworkExample
//
//  Created by admin on 21/03/22.
//

import Foundation
//MARK: - USINNG OBSERVABLE OBJECT

//class HomeViewModel {
//    var welcomeMessage: ObservableObject<String?> = ObservableObject(nil)
//    func getLoggedInUser() {
//        let user = NetworkService.shared.getLoggedInUser()
//        self.welcomeMessage.value = "Hello, \(user.firstName) \(user.lastName)"
//    }
//}

//MARK: - USINNG COMBINE
class HomeViewModel {
    @Published var welcomeMessage: String?
    func getLoggedInUser() {
        let user = NetworkService.shared.getLoggedInUser()
        self.welcomeMessage = "Hello, \(user.firstName) \(user.lastName)"
    }
}
