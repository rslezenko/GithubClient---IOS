//
//  ViewController.swift
//  GithubClient
//
//  Created by Roman Slezenko on 4/11/19.
//  Copyright © 2019 Roman Slezenko. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let githubAPI = "https://api.github.com/users/"
    var repoUrlAPI: String? = nil
    
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    @IBAction func check_nickname(_ sender: Any) {
        
        if(!textfield.text!.isEmpty){
            Alamofire.request(githubAPI + textfield.text!).responseJSON { response in
                switch(response.result){
                    case .success:
                        if let json = response.result.value as? [String:Any] {
                            if let repoUrl = json["repos_url"] {
                                    self.repoUrlAPI = repoUrl as? String
                                    self.performSegue(withIdentifier: "repos", sender: self)
                            }else{
                                  self.showAlert(text: "Nickname doesn’t exist in Github!")
                            }
                        }
                        break
                    case .failure:
                        self.showAlert(text: "Request Error!")
                        break
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewcontroller = segue.destination as! RepoViewController
        viewcontroller.repoURL = repoUrlAPI!
    }
    
    func showAlert(text error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

