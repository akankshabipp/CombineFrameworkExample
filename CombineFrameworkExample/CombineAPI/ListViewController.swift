//
//  ListViewController.swift
//  CombineFrameworkExample
//
//  Created by admin on 22/03/22.
//

import UIKit
import Combine

struct SampleModel : Codable {
    let title : String
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tblView: UITableView!
    
    var arr: [SampleModel] = []
    var subscriber : AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        self.title = "Example for Combine Framework"
       self.doApiCallWithCombine()
       // self.doApiCall()
    }
    
    // MARK: - USING API CALL
    func doApiCall(){
        NetworkingManager().getValueFromServer { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .success(let arrResponse):
                    self?.arr = arrResponse
                    self?.tblView.reloadData()
                    break
                }
            }
        }
    }
    
    // MARK: - USING COMBINE
    func doApiCallWithCombine() {
        subscriber = NetworkingManager().getValuesFromServerUsingCombine
            .sink(receiveCompletion: { (sub) in
                switch sub {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] (responseArr) in
                self?.arr = responseArr
                self?.tblView.reloadData()
            })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.arr[indexPath.row].title;
        return cell
    }
}
