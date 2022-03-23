//
//  NetworkingManager.swift
//  CombineFrameworkExample
//
//  Created by admin on 22/03/22.
//

import Foundation
import Combine

class NetworkingManager {
    // MARK: - USING API CALL
    func getValueFromServer(completion: @escaping (Swift.Result<[SampleModel], Error>)->()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            guard let data = data else {return}
            print(String(data: data, encoding: .utf8)!)
            
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try
                jsonDecoder.decode([SampleModel].self, from: data)
                print(responseModel)
                completion(.success(responseModel))
            } catch {
                print("Json serialisation error")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
// MARK: - USING COMBINE
var getValuesFromServerUsingCombine: AnyPublisher<[SampleModel], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { output in
            return output.data
        }
        .decode(type: [SampleModel].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

}
