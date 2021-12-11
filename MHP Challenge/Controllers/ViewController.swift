//
//  ViewController.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 07.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    let apiService = APIService()
    var houseArray: [IAFHouse]?
    var tempArray: [IAFHouse]?
    var pageSize: Int = 50
    var page: Int = 1
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        apiService.downloadData(page, 50) {(houseObject: [IAFHouse]?, error: Error?) -> Void in
            self.tempArray = houseObject
            self.houseArray = self.tempArray!.compactMap{$0}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(self.houseArray!)
            self.page += 1
        }
        
    }


}

extension ViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)

        if(houseArray != nil) {
            cell.textLabel?.text = houseArray![indexPath.row].name
            
            if indexPath.row == (houseArray!.count - 1) {
                if self.page < 10 {
                    apiService.downloadData(page, 50) {(houseObject: [IAFHouse]?, error: Error?) -> Void in
                        self.tempArray = houseObject
                        self.houseArray! += self.tempArray!.compactMap{$0}
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        print(self.houseArray!)
                        self.page += 1
                    }
                }
                
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (houseArray != nil) {
            return houseArray!.count
        } else {
            return 1
        }

    }



}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let houseObject = self.houseArray![indexPath.row]
        let houseDetailVC = HouseDetailVC()
        houseDetailVC.houseForDV = houseObject
        self.present(houseDetailVC, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
