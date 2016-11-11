//
//  PaymentViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import UIKit
import Eureka

class PaymentViewController: FormViewController {
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    @IBAction func confirmButtonTapped(_ sender: UIBarButtonItem) {
        showConfirmationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPaymentForm(toForm: form)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addPaymentForm(toForm form: Form) {
        //        let name: String
        //        let email: String
        //        let languageCode: String
        //        let address1: String
        //        let city: String
        //        let zip: String
        //        let countryCode: String
        form +++ Section("Customer Info")
            <<< NameRow(){ row in
                row.title = "Full Name"
                row.tag = "fullName"
                row.placeholder = "Customer's full name"
            }
            <<< NameRow(){ row in
                row.title = "Email"
                row.tag = "email"
                row.placeholder = "Customer's email"
            }
            <<< PushRow<String>(){ row in
                row.title = "Preferred Language"
                row.tag = "language"
                row.selectorTitle = "Language"
                row.options = ["EN", "DE", "FR"]
            }
            +++ Section("Customer Address")
            <<< NameRow(){ row in
                row.title = "Address Line 1"
                row.tag = "addressLine1"
                row.placeholder = "Address Line 1"
            }
            <<< NameRow(){ row in
                row.title = "Address Line 2"
                row.tag = "addressLine2"
                row.placeholder = "Address Line 2"
            }
            <<< NameRow(){ row in
                row.title = "Address Line 3"
                row.tag = "addressLine3"
                row.placeholder = "Address Line 3"
            }
            <<< NameRow(){ row in
                row.title = "City"
                row.tag = "city"
                row.placeholder = "City"
            }
            <<< NameRow(){ row in
                row.title = "Zip Code"
                row.tag = "zip"
                row.placeholder = "Zip Code"
            }
            <<< PushRow<String>(){ row in
                row.title = "Country"
                row.tag = "country"
                row.selectorTitle = "Country"
                row.options = ["GB", "DE", "FR", "US"]
        }
    }


// MARK: - Navigation

func showConfirmationView() {
    performSegue(withIdentifier: "ToConfirmation", sender: self)
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
}

}
