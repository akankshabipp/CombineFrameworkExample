//
//  FirstViewModel.swift
//  CombineFrameworkExample
//
//  Created by admin on 23/03/22.
//

import Foundation
import Combine
import UserNotifications

class NotificationviewModel {
    func authorize() -> AnyPublisher<Bool, Error> {
        Deferred {
            Future { handler in
                UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                        if let error = error {
                            handler(.failure(error))
                        }else {
                            handler(.success(granted))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }
}
