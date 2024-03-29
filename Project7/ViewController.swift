//
//  ViewController.swift
//  Project7
//
//  Created by Ahmed Adel on 4/28/19.
//  Copyright © 2019 Ahmed Adel. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlString : String
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) // use of let to make sure url is valid
            {
                if let data = try? Data(contentsOf: url){
                    //We are ok to go
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
        
        
    }
    
    func parse(json:Data)
    {
        let decoder = JSONDecoder() // used to convert between JSON and codeable objects
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                [weak self] in
                self?.tableView.reloadData()

            }
        }
    }
    
    func showError(){
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "Please check your connection and try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac,animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


}

