//
//  MainViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 10/18/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import Eureka
import Alamofire

class MainViewController: FormViewController {
    
    
    
    
    
    @IBAction func apiCallPressed(_ sender: UIBarButtonItem) {
        
        let passenger = ABPassenger(type: .adult, salutation: "MR", firstName: "Loris", lastName: "Mazloum", dateOfBirth: "1983-06-29")
        passenger.pId = "e0b49fd0-047b-42b3-a3a8-8cc2f7bcdd8a"
        
        let creditCard = ABCreditCard(number: "4111111111111111", type: .visa, holdersName: "Loris Mazloum", cvc: "123", expiryDate: "2019-03-21")
        creditCard.ccId = "f7ab0a71-d528-4276-9ce0-dcec862fa81d"
        
        let customerAddress = ABCustomerAddress(name: "Loris Mazloum", email: "loris.mazloum@gmail.com", languageCode: "EN", address1: "12345 street name", city: "Berlin", zip: "10405", countryCode: "DE")
        customerAddress.cId = "ae9b3367-c38d-4e6b-b3f1-77810a13369c"
        
        let flightSegment = ABFlightSegment(direction: "onward", fareCode: "NNYOW", date: "2016-11-11", number: "30BOPC8MG_20BPRT6VA")
        flightSegment.fsId = "73fc68ae-5ea8-4560-aba3-8c5514be9599"
        
        let booking = Booking(passengers: passenger, creditCard: creditCard, customerAddress: customerAddress, flightSegments: flightSegment)
        
        if let bookingJson = booking.toJSON() {
            print("Got Json")
            
            createNewBooking(with: bookingJson)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDestinationForm(toForm: form)
        
    }
    
    func createNewBooking(with bookingData: Data) {
        /**
         Create new booking
         POST https://app.xapix.io/api/v1//airberlin_lab_2016/bookings
         */
        
        // Add Headers
        
        guard let url = URL(string: "https://app.xapix.io/api/v1/airberlin_lab_2016/bookings") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ab16_LorisMaz:yWREONJp7XKuFrPjGDo8vaHCbZMB2zm6", forHTTPHeaderField: "Authorization")
        
        
        request.httpBody = bookingData
        
        //start api call
        print("Start API Call")
        Alamofire.request(request)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        
        
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
    
    private func addBookingForm(toForm form: Form) {
        
        //MARK: Definitions
        let today = NSDate()
        // format dates: http://mityugin.com/?p=244
        let tenYearsFromNow = NSCalendar.current.date(byAdding: .year, value: 10, to: today as Date)
        let hundredYearsAgo = NSCalendar.current.date(byAdding: .year, value: -100, to: today as Date)
        
        //MARK: Passport Form
        form +++ Section("Personal Info")
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
                row.tag = "dob"
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
                row.options = ["ANDORRA (AND)","AUSTRALIA (AUS)","AUSTRIA (AUT)","BELGIUM (BEL)","BRUNEI (BRN)","CZECH REPUBLIC (CZE)","DENMARK (DNK)","ESTONIA (EST)","FINLAND (FIN)","FRANCE (FRA)","GERMANY (DEU)","GREECE (GRC)","HUNGARY (HUN)","ICELAND (ISL)","IRELAND (IRL)","ITALY (ITA)","JAPAN (JPN)","LATVIA (LVA)","LIECHTENSTEIN (LIE)","LITHUANIA (LTU)","LUXEMBOURG (LUX)","MALTA (MLT)","MONACO (MCO)","NETHERLANDS (NLD)","NEW ZEALAND (NZL)","NORWAY (NOR)","PORTUGAL (PRT)","SAN MARINO (SMR)","SINGAPORE (SGP)","SLOVAKIA (SVK)","SLOVENIA (SVN)","SOUTH KOREA (KOR)","SPAIN (ESP)","SWEDEN (SWE)","SWITZERLAND (CHE)","UK - BRITISH CITIZEN (GBR)","UK - BRITISH DTC (GBD)","UK - BRITISH NATIONAL (O) (GBN)","UK - BRITISH OVERSEAS (GBO)","UK - BRITISH SUBJECT (GBS)","UK - PROTECTED PERSON (GBP)"]
                //$0.value = ""    // initially selected
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
    
}
