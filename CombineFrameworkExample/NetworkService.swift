//
//  NetworkService.swift
//  CombineFrameworkExample
//
//  Created by admin on 21/03/22.
//

import Foundation
class NetworkService {
    static let shared = NetworkService()
    var user: User?
    private init(){}
    func login(email: String, password: String, completion: @escaping(Bool) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in
            if email == "test@test.com" && password == "password" {
                self?.user = User(firstName: "testName", lastName: "testSurname",email: "test@test.com", age: 24)
                completion(true)
            }
                else {
                    self?.user = nil
                    completion(false)
                }
            }
        }
    func getLoggedInUser() -> User {
        return user!
    }
    }

