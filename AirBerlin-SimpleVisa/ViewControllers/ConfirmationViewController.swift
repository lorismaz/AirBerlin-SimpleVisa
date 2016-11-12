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
    var visa: String?
    
    let visaDetailsDictionnary = [
        "processing":"A visa was submitted to the destination's electronic system for travel authorization. It is still processing for now and it will be updated when complete. You will receive an email with the details of your visa.",
        "need_more_info": "Some additional information is needed to complete your visa. Please proceed to complete your visa application by tapping on the \"Complete Application\" button.",
        "approved": "Your visa has been approved and you can safely travel to your destination. An email with the details of your visa has been sent for your records. You don't need to print this email as the visa is registered in an electronic version and will be pulled up at your destination from your passport."
        ]
    
    //MARK: Outlets and Actions
    @IBOutlet weak var bookingRefLabel: UILabel!
    
    @IBOutlet weak var visaStatusLabel: UILabel!
    
    @IBOutlet weak var visaDetailsTextView: UITextView!
    
    @IBOutlet weak var nextStepButton: UIButton!
    
    @IBAction func nextStepButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func devButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        
        guard let unwrappedBooking = booking else {
            print("No Booking")
            return
        }
        
        bookingRefLabel.text = unwrappedBooking.bookingNumber
        
        visaStatusLabel.text = "Processing"
        visaDetailsTextView.text = visaDetailsDictionnary["processing"]
        nextStepButton.titleLabel?.text = "Complete Application"
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
