//
//  HomeViewController.swift
//  CombineFrameworkExample
//
//  Created by admin on 21/03/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var welcomLbl: UILabel!
    private let viewModel = HomeViewModel()
    //for Combine
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        viewModel.getLoggedInUser()
       
    }
    //MARK: - USING OBSERABLES
//    private func setUpBinders(){
//        viewModel.welcomeMessage.bind { [weak self] message in
//            self?.welcomLbl.text = message
//
//        }
//    }
    // MARK: - USING COMBINE
        private func setUpBinders(){
            viewModel.$welcomeMessage.sink { [weak self] message in
                self?.welcomLbl.text = message
            }.store(in: &cancellables)
        }

}
