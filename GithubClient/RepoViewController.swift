//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Roman Slezenko on 4/12/19.
//  Copyright © 2019 Roman Slezenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RepoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var repoURL = String()
    var linkUrl = String()
    
    @IBOutlet var tableview: UITableView!
    
    struct Data {
        let name:String?
        let url:String?
    }

    var dataArray: [Data] = []
    
    override func viewWillAppear(_ animated: Bool) {
        for cell in tableview.visibleCells {
            cell.setSelected(false, animated: true)
        }
        tableview.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        Alamofire.request(repoURL).responseJSON { response in
            switch(response.result){
                case .success:
                    guard let object = response.result.value else {
                        print("Oh, no!!!")
                        return
                    }
                    let json = JSON(object)
                    if let jArray = json.array {
                        for element in jArray {
                                if let name = element["name"].string,
                                    let url = element["html_url"].string{
                                    self.dataArray.append(Data(name: name, url: url))
                                 }
                                }
                            self.tableview.reloadData()
                        }
                    break
                case .failure:
                    self.showAlert(text: "Request Error!")
                    break
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = dataArray[indexPath.row].name
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        linkUrl = dataArray[indexPath.row].url!
        self.performSegue(withIdentifier: "segue_details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewcontroller = segue.destination as! DetailsViewController
        viewcontroller.link = linkUrl
    }

    func showAlert(text error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
