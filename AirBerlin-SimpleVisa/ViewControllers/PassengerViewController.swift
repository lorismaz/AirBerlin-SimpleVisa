//
//  PassengerViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import UIKit
import Eureka
import SimpleVisa
class PassengerViewController: FormViewController {
    
    var passenger: ABPassenger?
    var visaNeeded: Bool = false

    let activityIndicator = UIActivityIndicatorView()
    var spinner = UIBarButtonItem()
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        
        let passengerDictionary = form.values()
        guard let firstName = passengerDictionary["firstName"] as? String,
            let lastName = passengerDictionary["lastName"] as? String,
            let sex = passengerDictionary["sex"] as? String,
            let dateOfBirth = passengerDictionary["dateOfBirth"] as? Date,
            let passportIssuingCountry = passengerDictionary["passportIssuingCountry"] as? String,
            let passportNumber = passengerDictionary["passportNumber"] as? String,
            let passportExpiringDate = passengerDictionary["passportExpiringDate"] as? Date
            else {
                print("Error parsing form data")
                return
        }
        
        var passengerSex = "M"
        if sex == "Female" {
            passengerSex = "F"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateOfBirthString = dateFormatter.string(from: dateOfBirth)
        let expiringDateString = dateFormatter.string(from: passportExpiringDate)
        
        print(">>> \(passportNumber) ")
        
        let newPassport = SVPassport(firstName: firstName, lastName: lastName, sex: passengerSex, dateOfBirth: dateOfBirthString, number: passportNumber, issuingCountry: passportIssuingCountry, issuanceDate: "", expiringDate: expiringDateString)
        
        do {
            
            self.activityIndicator.startAnimating()
            self.navigationItem.rightBarButtonItem = spinner
            
            try SimpleVisaClient.checkPassport(passport: newPassport)
        } catch {
            self.activityIndicator.stopAnimating()
            print(error.localizedDescription)
        }
        
        //showPaymentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        spinner = UIBarButtonItem(customView: activityIndicator)
        
        
        prepareSimpleVisa()
        
        addPassengerForm(toForm: form)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addPassengerForm(toForm form: Form) {
        
        let today = NSDate()
        // format dates: http://mityugin.com/?p=244
        let tenYearsFromNow = NSCalendar.current.date(byAdding: .year, value: 10, to: today as Date)
        let hundredYearsAgo = NSCalendar.current.date(byAdding: .year, value: -100, to: today as Date)
        
        //MARK: Passport Form
        form +++ Section("Personal Info")
            <<< PushRow<String>(){ row in
                row.title = "Salutation"
                row.tag = "salutation"
                row.selectorTitle = "Salutation"
                row.options = ["MR","MISS","MRS"]
            }
            <<< NameRow(){ row in
                row.title = "First Name"
                row.tag = "firstName"
                row.placeholder = "Enter your first (given) name"
            }
            <<< NameRow(){ row in
                row.title = "Last Name"
                row.tag = "lastName"
                row.placeholder = "Enter your last (family) name"
            }
            <<< DateRow(){ row in
                row.title = "Date of Birth"
                row.tag = "dateOfBirth"
                //$0.value = NSDate(timeIntervalSinceReferenceDate: 0) as Date
                row.maximumDate = today as Date
                row.minimumDate = hundredYearsAgo! as Date
            }
            <<< SegmentedRow<String>(){ row in
                row.title = "Sex"
                row.tag = "sex"
                row.selectorTitle = "Set your sex"
                row.options = ["Male","Female"]
                //$0.value = "Male"    // initially selected
            }
            +++ Section("Passport Info")
            <<< PushRow<String>(){ row in
                row.title = "Passport Issuing Country"
                row.tag = "passportIssuingCountry"
                row.selectorTitle = "Passport Issuing Country"
                row.options = ["AN","AU","AT","BE","DN","FR","DE","GR","HU","IE","IT"]
            }
            <<< TextRow(){ row in
                row.title = "Passport Number"
                row.tag = "passportNumber"
                row.placeholder = "Set your passport number"
                row.add(rule: RuleMaxLength(maxLength: 9))
                row.validationOptions = .validatesOnChange
                }.onChange { row in
                    //row.title = (row.value ?? false) ? "The title expands when on" : "The title"
                    //http://stackoverflow.com/a/28571100/512325
                    //remove anaything that is not number or letter.
                    row.value = row.value?.uppercased()
                    row.updateCell()
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< DateRow(){ row in
                row.title = "Passport Expiring Date"
                row.tag = "passportExpiringDate"
                //$0.value = NSDate(timeIntervalSinceReferenceDate: 0) as Date
                row.minimumDate = today as Date
                row.maximumDate = tenYearsFromNow! as Date
        }
        
    }
    
    // MARK: - Navigation
    func showPaymentView() {
        performSegue(withIdentifier: "ToPayment", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}

extension PassengerViewController: SimpleVisaClientDelegate {
    
    func prepareSimpleVisa() {
        SimpleVisaClient.delegate = self
    }
    
    func didReceivePrograms(programs: [SVProgram]) {
        //
    }
    
    func didFinishCheckingPassport(authorization: Bool) {
        print("Got passport authorization and result is \(authorization)")
        
        if !authorization {
            print("need a new visa")
            self.visaNeeded = true
        } else {
            print("no visa needed")
        }
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            self.showPaymentView()
        }
        
    }
    
}
