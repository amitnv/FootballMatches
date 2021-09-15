//
//  ViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import UIKit

class ViewController: UIViewController {
    var matches = Matches()
    var matchDetails = [Match]()
    @IBOutlet weak var tableViewForMatches: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewForMatches.dataSource = self
        let service = Service(baseUrl: "https://api.football-data.org/v2/competitions/2001/matches?dateFrom=\(dateThirtyDaysback())&dateTo=")
        service.getAllMatches(todaysDate: getTodaysDate())
        service.completitonHandler { [weak self](matches, status, message) in
            if status {
                guard let self = self else {return}
                guard let _matches = matches else {return}
                self.matches = _matches
                guard (matches?.matches) != nil else {return}
                self.matchDetails = _matches.matches!
                self.tableViewForMatches.reloadData()
                self.compareWins()
            }
        }
        
    }
    func getTodaysDate() -> String{
        let date = Date()
        return formatDate(date: date)
    }
    func dateThirtyDaysback() -> String{
        let toDate = Date()
        let fromDate = Calendar.current.date(byAdding: .day, value: -30, to: toDate)
        return formatDate(date: fromDate!)
        
    }
    func formatDate(date : Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        return dateString
    }
    func compareWins() {
        //print result at each level
        //count of matches
        let matchcount = matchDetails.count
        print("No. of matches is \(matchcount)")
        
        for allStat in matchDetails {
            //check if match is finished or not because only finished matches will have result
            if allStat.status == Status.finished {
                //check if match winner value was away_team or home_team and eliminate draw results
                if allStat.score.winner != Winner.draw {
                    print("PPP: \(String(describing: allStat.score.winner?.rawValue))")
                    //if winner is away team then
//                    allStat.awayTeam
                    //take id of winner team
                    //count the number of ids repeated
                    //show the result
                    
                }
                
            }
        }
        
        //store hometeam or awayteam id based on that
        //count the number of ids repeated
        //display alert based on that
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
        cell?.textLabel?.text = (country.homeTeam.name ?? "") + " v " + (country.awayTeam.name ?? "")
        if((country.score.winner?.rawValue) != nil) {
            cell?.detailTextLabel?.text = country.score.winner?.rawValue
        } else {
            cell?.detailTextLabel?.text = "SCHEDULED"
        }
        
        return cell!
    }
    
    
}
