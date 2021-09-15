//
//  InitialViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 15/09/2021.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var showMatches: UIButton!
    @IBOutlet weak var mostWins: UIButton!
    
    var matches = Matches()
    var matchDetails = [Match]()
    var winnerIDs: [Int] = []
    var teamWithHighestWins : String?
    
    @IBAction func mostWinsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: "MostWinsViewController") as! MostWinsViewController
        let passData = teamWithHighestWins!
        secondVC.setDataReference(dataReference: passData)
                self.navigationController?.pushViewController(secondVC, animated: true)
                print("filter button tapped")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = Service(baseUrl: "https://api.football-data.org/v2/competitions/2001/matches?dateFrom=\(dateThirtyDaysback())&dateTo=")
        service.getAllMatches(todaysDate: getTodaysDate())
        service.completitonHandler { [weak self](matches, status, message) in
            if status {
                guard let self = self else {return}
                guard let _matches = matches else {return}
                self.matches = _matches
                guard (matches?.matches) != nil else {return}
                self.matchDetails = _matches.matches!
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
                //check if match winner value was away_team or home_team and eliminate draw/null results
                if allStat.score.winner != nil {
                    if allStat.score.winner != Winner.draw {
//                        print("PPP: \(String(describing: allStat.score.winner?.rawValue))")
                        
                        //Store hometeam or awayteam id based on that
                        if allStat.score.winner?.rawValue == "AWAY_TEAM" {
//                            print("ids are: \(String(describing: allStat.awayTeam.id))!")
                            winnerIDs.append(allStat.awayTeam.id!)
                            
                        } else {
//                            print("ids are: \(String(describing: allStat.homeTeam.id))!")
                            winnerIDs.append(allStat.homeTeam.id!)
                        }
                    }
                }
            }
        }
        print(winnerIDs)
        
        //count the number of WinnerIds repeated and place them in a dictionary
        let countOfEachID = winnerIDs.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        print(countOfEachID)
        
        //sort them in decending order of values
        let sortedByValueDictionary = countOfEachID.sorted { $0.1 > $1.1 }
        print(sortedByValueDictionary)
        
        //Show the first element's key which will have the highest value after sorting
        let firstValue = sortedByValueDictionary.first?.key
        print(firstValue!)
        
        
        for lookupTeamName in matchDetails {
            if lookupTeamName.awayTeam.id == firstValue! {
                teamWithHighestWins = lookupTeamName.awayTeam.name
            }
            if lookupTeamName.homeTeam.id == firstValue! {
                teamWithHighestWins = lookupTeamName.homeTeam.name
            }
        }
//        print(teamWithHighestWins!)
//        //display alert based on that
//        let alert = UIAlertController(title: "The team with highest win is", message: "\(teamWithHighestWins!)", preferredStyle: .alert)
//        // add an action (button)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        // show the alert
//                self.present(alert, animated: true, completion: nil)
    }
}
