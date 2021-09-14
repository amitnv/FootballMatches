//
//  ViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import UIKit

class ViewController: UIViewController {
    var matches = Matches()
    var areas = [Area]()
    
    @IBOutlet weak var tableViewForMatches: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewForMatches.dataSource = self
        let service = Service(baseUrl: "https://api.football-data.org/v2/areas")
        service.getAllMatches(endPoint: "")
        service.completitonHandler { [weak self](matches, status, message) in
            if status {
                guard let self = self else {return}
                guard let _matches = matches else {return}
                self.matches = _matches
                guard (matches?.areas) != nil else {return}
                self.areas = _matches.areas!
                self.tableViewForMatches.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "matchesCell")
        }
        let country = areas[indexPath.row]
        cell?.textLabel?.text = (country.name ?? "") + " " + (country.countryCode ?? "")
        cell?.detailTextLabel?.text = country.parentArea
        return cell!
    }
    
    
}
