//
//  MostWinsViewController.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 15/09/2021.
//

import UIKit

class MostWinsViewController: UIViewController {
    
    //MARK:- Variables
    var newDet: String = ""
    
    //MARK:- IBOutlet
    @IBOutlet weak var lblTeamName: UILabel!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTeamName.text = self.newDet
    }
    
    //MARK:- Function
    func setDataReference(dataReference: String)
    {
        self.newDet = dataReference
    }
    
}
