//
//  ViewModel.swift
//  CombineFrameworkExample
//
//  Created by admin on 18/03/22.
//

import Foundation
//MARK: - ObservableObject CODE
class LoginViewModel {
    var error: ObservableObject<String?> = ObservableObject(nil)
    func login(email: String, password: String){
        NetworkService.shared.login(email: email, password: password) {
            [weak self] success in
            self?.error.value = success ? nil : "Invalid credential"
        }
    }
}
//MARK: - USING COMBINE
//class LoginViewModel {
//    @Published var error: String?
//    func login(email: String, password: String){
//        NetworkService.shared.login(email: email, password: password) {
//            [weak self] success in
//            self?.error = success ? nil : "Invalid credential"
//        }
//    }
//}
