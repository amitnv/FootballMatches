//
//  ViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Variables
    var matches = Matches()
    var matchDetails = [Match]()
    var limit = 20
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableViewForMatches: UITableView!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewForMatches.dataSource = self
    }
}

//MARK:- Extension
extension ViewController: UITableViewDataSource, UIScrollViewDelegate {
    
    //MARK:-Pagination
    @objc func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == matchDetails.count - 1 {
            // we are at last cell load more content
            if matchDetails.count < AppConstants.totalEntries {
                // we need to bring more matches as there are some pending matches available
                var index = matchDetails.count
                limit = index + 20
                while index < limit {
                    matchDetails.append(contentsOf: matches.matches!)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 0.4)
            }
        }
    }
    
    @objc func loadTable() {
        self.tableViewForMatches.reloadData()
    }
    
    //MARK:- Table View DataSource stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell1 = tableView.dequeueReusableCell(withIdentifier: AppConstants.matchesCell) else {return UITableViewCell()}
        var cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.matchesCell)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: AppConstants.matchesCell)
        }
        var winnerName: String = ""
        
        if(matchDetails.count > 0) {
            //Club or country name, excuse my poor football knowledge
            let club = matchDetails[indexPath.row]
            cell?.textLabel?.text = (club.homeTeam.name ?? "") + AppConstants.versus + (club.awayTeam.name ?? "")
            if((club.score.winner?.rawValue) != nil) {
                
                //Add text data to detail Text label view based on winner
                if club.score.winner?.rawValue == AppConstants.awayTeam  {
                    winnerName = AppConstants.winner + club.awayTeam.name!
                } else if club.score.winner?.rawValue == AppConstants.homeTeam {
                    winnerName = AppConstants.winner + club.homeTeam.name!
                } else {
                    winnerName = AppConstants.draw
                }
                cell?.detailTextLabel?.text = winnerName
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            } else {
                cell?.detailTextLabel?.text = AppConstants.cancelled
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            }
        }
        else {
            cell?.detailTextLabel!.text = "No matches are being played"
        }
        return cell!
    }
}
