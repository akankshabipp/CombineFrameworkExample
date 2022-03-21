//
//  NewViewController.swift
//  CombineFrameworkExample
//
//  Created by admin on 18/03/22.
//

import UIKit
import Combine

class NewViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    private let viewModel = LoginViewModel()
    //Using Combine
  //  private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
     setUpBinders()
      
    }
    //MARK: - USINNG OBSERVABLE OBJECT
    private func setUpBinders() {
        viewModel.error.bind {[weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.goToHomePage()
            }
        }
    }
    //MARK: - USINNG COMBINE
//        private func setUpBinders() {
//            viewModel.$error.sink { [weak self] error in
//                if let error = error {
//                    print(error)
//                } else {
//                    self?.goToHomePage()
//                }
//
//            }.store(in: &cancellables)
//        }
    private func goToHomePage(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        present(controller, animated: true, completion: nil)
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        guard let email = emailField.text,
              let password = passwordField.text else {
                  print("Please enter email and password")
                  return
              }
        viewModel.login(email: email, password: password)
    }
    
}
