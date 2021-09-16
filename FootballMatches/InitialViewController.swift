//
//  InitialViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 15/09/2021.
//

import UIKit

class InitialViewController: UIViewController {
    
    //MARK:- Variables
    var matches = Matches()
    var matchDetails = [Match]()
    var winnerIDs: [Int] = []
    var teamWithHighestWins : String?
    var moveDateBackBy = -31
    
    //MARK:- IBOutlets
    @IBOutlet weak var showMatches: UIButton!
    @IBOutlet weak var mostWins: UIButton!
    
    //MARK:- IBAction
    @IBAction func mostWinsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: "MostWinsViewController") as! MostWinsViewController
        let passData = teamWithHighestWins!
        secondVC.setDataReference(dataReference: passData)
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func showMatchesTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let moveData = matches
        secondVC.matches = moveData
        let moveMatchDetails = matchDetails
        secondVC.matchDetails = moveMatchDetails
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        callFootballAPI(dateFromValue: dateRewindBy(rewindInt: AppConstants.lastThirtyDays))
    }
    
    //MARK:- FUNCTIONS
    //improvement: move this bit somewhere else?
    func callFootballAPI(dateFromValue: String) {
        let service = Service(baseUrl: "https://api.football-data.org/v2/competitions/2001/matches?dateFrom=\(dateFromValue)&dateTo=")
        service.getAllMatches(todaysDate: getTodaysDate())
        print("date from: \(dateFromValue), date to: \(getTodaysDate())")
        service.completitonHandler { [weak self](matches, status, message) in
            if status {
                guard let self = self else {return}
                guard let _matches = matches else {return}
                self.matches = _matches
                guard (matches?.matches) != nil else {return}
                self.matchDetails = _matches.matches!
                self.compareWins()
            }else {
                print(message)
            }
            
        }
    }
    
    //MARK:- Date related functions
    func getTodaysDate() -> String{
        let date = Date()
        return formatDate(date: date)
    }
    
    func dateRewindBy(rewindInt: Int) -> String{
        let toDate = Date()
        let fromDate = Calendar.current.date(byAdding: .day, value: rewindInt, to: toDate)
        return formatDate(date: fromDate!)
    }
    
    func formatDate(date : Date) -> String{
        let df = DateFormatter()
        df.dateFormat = AppConstants.dateFormat
        let dateString = df.string(from: date)
        return dateString
    }
    
    //Check of highest number of wins
    func compareWins() {
        //count of matches
        let matchcount = matchDetails.count
        print("No. of matches is \(matchcount)")
        if matchcount > 0 {
            for allStat in matchDetails {
                //check if match is finished or not because only finished matches will have result
                if allStat.status == Status.finished {
                    //check if match winner value was away_team or home_team and eliminate draw/null results
                    if allStat.score.winner != nil {
                        if allStat.score.winner != Winner.draw {
                            //                        print("PPP: \(String(describing: allStat.score.winner?.rawValue))")
                            
                            //Store hometeam or awayteam id based on that
                            if allStat.score.winner?.rawValue == AppConstants.awayTeam {
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
        }
        
//        print(winnerIDs)
        if winnerIDs.isEmpty {
            //logic for last completed game, Improvement: Explore other API?
            while (matchcount == 0) {
                callFootballAPI(dateFromValue: dateRewindBy(rewindInt: moveDateBackBy))
                moveDateBackBy -= 1
            }
            
            if let homeTeamName  = matchDetails.first!.homeTeam.name, let awayTeamName =  matchDetails.first!.awayTeam.name {
                teamWithHighestWins = homeTeamName + AppConstants.versus + awayTeamName
            }
        } else {
            //count the number of WinnerIds repeated and place them in a dictionary
            let countOfEachID = winnerIDs.reduce(into: [:]) { $0[$1, default: 0] += 1 }
//            print(countOfEachID)
            
            //sort them in decending order of values
            let sortedByValueDictionary = countOfEachID.sorted { $0.1 > $1.1 }
//            print(sortedByValueDictionary)
            
            //Show the first element's key which will have the highest value after sorting
            let firstValue = sortedByValueDictionary.first?.key
//            print(firstValue!)
            
            
            for lookupTeamName in matchDetails {
                if lookupTeamName.awayTeam.id == firstValue! {
                    teamWithHighestWins = lookupTeamName.awayTeam.name
                }
                if lookupTeamName.homeTeam.id == firstValue! {
                    teamWithHighestWins = lookupTeamName.homeTeam.name
                }
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

//Extension that adds more options in the interface builder for UIButton
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
