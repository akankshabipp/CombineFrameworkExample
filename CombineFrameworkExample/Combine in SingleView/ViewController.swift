//
//  ViewController.swift
//  CombineFrameworkExample
//
//  Created by admin on 17/03/22.
//

import UIKit
import Combine

extension Notification.Name {
    static let newMessage = Notification.Name("newMessage")
}
struct Message {
    let content: String
    let author: String
}
class ViewController: UIViewController {

    @IBOutlet weak var allowMessagesSwitch: UISwitch!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    @Published var canSendMessages: Bool = false
    private var switchSubcriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpProcessingChain()
    }
    func setUpProcessingChain(){
        switchSubcriber = $canSendMessages.receive(on: DispatchQueue.main).assign(to: \.isEnabled, on: sendButton)
        let messagePublisher = NotificationCenter.Publisher(center: .default, name:.newMessage)
            .map { notification -> String? in
                return (notification.object as? Message)?.content ?? ""
            }
        let messageSubscriber = Subscribers.Assign(object: messageLabel, keyPath: \.text)
        messagePublisher.subscribe(messageSubscriber)
    }
    
    @IBAction func didSwitch(_ sender: Any) {
        canSendMessages = (sender as AnyObject).isOn
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = Message(content: "The Current Time is \(Date())", author: "Me")
        NotificationCenter.default.post(name: .newMessage, object: message)
    }
}

