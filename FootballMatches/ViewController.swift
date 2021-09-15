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
    var matchDetails = [Match]()
    @IBOutlet weak var tableViewForMatches: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewForMatches.dataSource = self
        let service = Service(baseUrl: "https://api.football-data.org/v2/competitions/2001/matches?dateFrom=2021-08-14&dateTo=2021-09-13")
        service.getAllMatches(endPoint: "")
        service.completitonHandler { [weak self](matches, status, message) in
            if status {
                guard let self = self else {return}
                guard let _matches = matches else {return}
                self.matches = _matches
                guard (matches?.matches) != nil else {return}
                self.matchDetails = _matches.matches!
                self.tableViewForMatches.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "matchesCell")
        }
        let country = matchDetails[indexPath.row]
        cell?.textLabel?.text = (country.homeTeam.name ?? "") + " " + (country.awayTeam.name ?? "")
        cell?.detailTextLabel?.text = country.score.winner.rawValue
        return cell!
    }
    
    
}
