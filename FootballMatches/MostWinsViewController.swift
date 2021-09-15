//
//  MostWinsViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 15/09/2021.
//

import UIKit

class MostWinsViewController: UIViewController {
    var matches = Matches()
    var matchDetails = [Match]()
    var winnerIDs: [Int] = []
    var newDet: String = ""
    @IBOutlet weak var lblTeamName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTeamName.text = self.newDet
    }
    func setDataReference(dataReference: String)
    {
        self.newDet = dataReference
    }
    
}
