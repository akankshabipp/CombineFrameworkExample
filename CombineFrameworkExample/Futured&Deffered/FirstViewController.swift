//
//  FirstViewController.swift
//  CombineFrameworkExample
//
//  Created by admin on 23/03/22.
//

import UIKit
import Combine
import UserNotifications

class FirstViewController: UIViewController {
    private let notificationViewModel = NotificationviewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var displayLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func askPermissionBtnAction(_ sender: Any) {
        notificationViewModel
            .authorize()
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                self?.displayLbl.text = "Status: \(val ? "Granted" : "Denied")"
                
            }
            .store(in: &subscriptions)
    }
}
