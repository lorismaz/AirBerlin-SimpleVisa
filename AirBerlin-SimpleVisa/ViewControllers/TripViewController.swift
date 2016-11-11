//
//  TripViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import UIKit
import Eureka

class TripViewController: FormViewController {

    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        showPassengerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDestinationForm(toForm: form)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func addDestinationForm(toForm form: Form) {
        
        form +++ Section("Your Trip")
            <<< PushRow<String>(){ row in
                row.title = "Departure Airport"
                row.tag = "departureAirport"
                row.selectorTitle = "Departure Airport"
                row.options = ["TXL"]
            }
            <<< PushRow<String>(){ row in
                row.title = "Destination Airport"
                row.tag = "destinationAirport"
                row.selectorTitle = "Destination Airport"
                row.options = ["NYC"]
        }
    }
    

    // MARK: - Navigation

    func showPassengerView() {
        performSegue(withIdentifier: "ToPassenger", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

}
