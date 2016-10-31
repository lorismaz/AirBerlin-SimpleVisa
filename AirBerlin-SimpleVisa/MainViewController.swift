//
//  MainViewController.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 10/18/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//

import Eureka

class MainViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBookingForm(toForm: form)
        
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
