//
//  PaymentViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import UIKit
import Eureka
import EurekaCreditCard

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
        
        let today = NSDate()
        // format dates: http://mityugin.com/?p=244
        let twentyYearsFromNow = NSCalendar.current.date(byAdding: .year, value: 20, to: today as Date)
        
        form +++ Section("Customer Info")
            <<< NameRow(){ row in
                row.title = "Full Name"
                row.tag = "fullName"
                row.placeholder = "Customer's full name"
            }
            <<< EmailRow(){ row in
                row.title = "Email"
                row.tag = "email"
                row.placeholder = "Customer's email"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
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
            <<< ZipCodeRow(){ row in
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
            +++ Section("Credit Card")
            <<< NameRow(){ row in
                row.title = "Holder's Name"
                row.tag = "holdersName"
                row.placeholder = "Full name"
            }
            <<< CreditCardRow() {
                //$0.title = "Card"
                $0.cardNumberPlaceholder = "Card Number"
                $0.expirationMonthPlaceholder = "MM"
                $0.expirationYearPlaceholder = "YY"
                $0.cvcPlaceholder = "CVC"
                //$0.dataSectionWidthPercentage = CGFloat(0.5)
                //            $0.value = CreditCard()
                $0.value = CreditCard(
                    cardNumber: "",
                    expirationMonth: "",
                    expirationYear: "",
                    cvc: ""
                )
        }
        //
        //            <<< PushRow<String>(){ row in
        //                row.title = "Type"
        //                row.tag = "type"
        //                row.selectorTitle = "Type"
        //                row.options = ["VI", "MC", "AM"]
        //            }
        //            <<< IntRow(){ row in
        //                row.title = "Number"
        //                row.tag = "number"
        //                row.placeholder = "Credit card number"
        //
        //            }
        //            <<< DateRow(){ row in
        //                row.title = "Expiration Date"
        //                row.tag = "expirationDate"
        //                row.minimumDate = today as Date
        //                row.maximumDate = twentyYearsFromNow! as Date
        //            }
        //            <<< IntRow(){ row in
        //                row.title = "CVC"
        //                row.tag = "cvc"
        //                row.placeholder = "Security code on back of card"
        //            }
        
    }
    
    
    // MARK: - Navigation
    
    func showConfirmationView() {
        performSegue(withIdentifier: "ToConfirmation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
