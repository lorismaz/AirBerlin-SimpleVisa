//
//  ConfirmationViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import UIKit
import SimpleVisa

class ConfirmationViewController: UIViewController {
    
    //MARK: Properties
    var booking: ABBooking?
    var bookingNumber: String!
    var visa: [String: Any] = ["status":"Visa Processing",
                               "text": "A visa was submitted to the destination's electronic system for travel authorization. It is still processing for now and it will be updated when complete. You will receive an email with the details of your visa.",
                               "buttonText":"",
                               "number":""
    ]
    
    //MARK: Outlets and Actions
    @IBOutlet weak var bookingRefLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var visaNumberLabel: UILabel!
    
    @IBOutlet weak var visaReferenceLabel: UILabel!
    
    @IBOutlet weak var visaStatusLabel: UILabel!
    
    @IBOutlet weak var visaDetailsTextView: UITextView!
    
    @IBOutlet weak var nextStepButton: UIButton!
    
    @IBAction func nextStepButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func devButtonTapped(_ sender: UIBarButtonItem) {
        devActions()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let visaStatus = visa["status"] as? String else { return }
        
        visaStatusLabel.text = visaStatus
        visaNumberLabel.text = visa["number"] as! String?
        visaDetailsTextView.text = visa["text"] as! String?
        nextStepButton.setTitle(visa["buttonText"] as! String?, for: .normal)
        
        switch visaStatus {
        case "Visa Processing":
            visaReferenceLabel.isHidden = true
            visaNumberLabel.isHidden = true
            nextStepButton.isHidden = true
        case "Visa Approved":
            visaReferenceLabel.isHidden = false
            visaNumberLabel.isHidden = false
            nextStepButton.isHidden = true
        case "More Details Needed":
            visaReferenceLabel.isHidden = true
            visaNumberLabel.isHidden = true
            nextStepButton.isHidden = false
        default:
            visaReferenceLabel.isHidden = true
            visaNumberLabel.isHidden = true
            nextStepButton.isHidden = true
        }
        
        
        guard let bookingNumber = self.bookingNumber else { return }
        bookingRefLabel.text = bookingNumber
        
    }
    
    func prepareBooking() {
        
        let passenger = ABPassenger(type: .adult, salutation: "MR", firstName: "Loris", lastName: "Mazloum", dateOfBirth: "1983-06-29")
        passenger.pId = "d1d1593c-6227-4cb0-96e8-b03221c2fce6"
        
        let creditCard = ABCreditCard(number: "4111111111111111", type: .visa, holdersName: "Loris Mazloum", cvc: "123", expiryDate: "2019-03-21")
        creditCard.ccId = "f7ab0a71-d528-4276-9ce0-dcec862fa81d"
        
        let customerAddress = ABCustomerAddress(name: "Loris Mazloum", email: "loris.mazloum@gmail.com", languageCode: "EN", address1: "12345 street name", city: "Berlin", zip: "10405", countryCode: "DE")
        customerAddress.cId = "3116d49f-2363-4b3c-8243-8cef715d9d50"
        
        let flightSegment = ABFlightSegment(direction: "onward", fareCode: "NNYOW", date: "2016-11-11", number: "30BOPC8MG_20BPRT6VA")
        flightSegment.fsId = "b87a61bc-b098-4142-afb5-3d1f54875f85"
        
        
        self.booking = ABBooking(passengers: passenger, creditCard: creditCard, customerAddress: customerAddress, flightSegments: flightSegment)
    }
    
    
    func devActions() {
        
        // instantiate an alert controller
        let myAlertController = UIAlertController(title: "Dev Actions", message: "Set the visa status", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let processingAction = UIAlertAction(title: "Processing", style: .default) { (action) in
            self.visaProcessing()
        }
        
        let moreDetailsAction = UIAlertAction(title: "Details Needed", style: .default) { (action) in
            self.visaNeedDetails()
        }
        
        let approvedAction = UIAlertAction(title: "Approved", style: .default) { (action) in
            self.visaApproved()
        }
        
        myAlertController.addAction(moreDetailsAction)
        myAlertController.addAction(processingAction)
        myAlertController.addAction(approvedAction)
        myAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(myAlertController, animated: true) { }
        
    }
    
    func visaProcessing() {
        print("processing tapped")
        
        self.visa = ["status":"Visa Processing",
                     "text": "A visa was submitted to the destination's electronic system for travel authorization. It is still processing for now and it will be updated when complete. You will receive an email with the details of your visa.",
                     "buttonText":"",
                     "number":""
        ]
        
        guard let visaStatus = self.visa["status"] as? String else { return }
        
        visaStatusLabel.text = visaStatus
        visaNumberLabel.text = visa["number"] as! String?
        visaDetailsTextView.text = visa["text"] as! String?
        nextStepButton.setTitle(visa["buttonText"] as! String?, for: .normal)
        
        visaReferenceLabel.isHidden = true
        visaNumberLabel.isHidden = true
        nextStepButton.isHidden = true
        
    }
    
    func visaApproved() {
        print("approved tapped")
        
        self.visa = ["status":"Visa Approved",
                     "text": "Your visa has been approved and you can safely travel to your destination. An email with the details of your visa has been sent for your records. You don't need to print this email as the visa is registered in an electronic version and will be pulled up at your destination from your passport.",
                     "buttonText":"",
                     "number":"XX898SSFH23I3HSDF8"
        ]
        
        guard let visaStatus = self.visa["status"] as? String else { return }
        
        visaStatusLabel.text = visaStatus
        visaNumberLabel.text = visa["number"] as! String?
        visaDetailsTextView.text = visa["text"] as! String?
        nextStepButton.setTitle(visa["buttonText"] as! String?, for: .normal)
        
        visaReferenceLabel.isHidden = false
        visaNumberLabel.isHidden = false
        nextStepButton.isHidden = true
        
        
    }
    
    func visaNeedDetails() {
        print("more details needed tapped")
        
        self.visa = ["status":"More Details Needed",
                     "text": "Some additional information is needed to complete your visa. Please proceed to complete your visa application by tapping on the \"Complete Application\" button.",
                     "buttonText":"Complete Application",
                     "number":""
        ]
        
        guard let visaStatus = self.visa["status"] as? String else { return }
        
        titleLabel.text = "Visa need additional info"
        visaStatusLabel.text = visaStatus
        visaNumberLabel.text = visa["number"] as! String?
        visaDetailsTextView.text = visa["text"] as! String?
        nextStepButton.setTitle(visa["buttonText"] as! String?, for: .normal)
        
        visaReferenceLabel.isHidden = true
        visaNumberLabel.isHidden = true
        nextStepButton.isHidden = false
    }
    
}
