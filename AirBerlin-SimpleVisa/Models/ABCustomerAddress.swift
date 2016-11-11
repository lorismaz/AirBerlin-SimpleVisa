//
//  ABCustomerAddress.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//
//{
//    "c_id": "c8986bac-36c7-4ac6-b38d-324bdfe9caf5",
//    "zip": "91601",
//    "name": "Loris Mazloum",
//    "country_code": "US",
//    "city": "North Hollywood",
//    "address1": "11135 Weddington St",
//    "email": "loris.mazloum@gmail.com",
//    "language_code": "EN"
//}

import Foundation

class ABCustomerAddress {
    let name: String
    let email: String
    let languageCode: String
    let address1: String
    let city: String
    let zip: String
    let countryCode: String
    var cId: String? = nil
    
    public init(name: String, email: String, languageCode: String, address1: String, city: String, zip: String, countryCode: String) {
        self.name = name
        self.email = email
        self.languageCode = languageCode
        self.address1 = address1
        self.city = city
        self.zip = zip
        self.countryCode = countryCode
    }
    
    func toJSON() -> Data? {
        let data = [ "data":
            [
                "zip": self.zip,
                "name": self.name,
                "country_code": self.countryCode,
                "city": self.city,
                "address1": self.address1,
                "email": self.email,
                "language_code": self.languageCode
            ]
        ]
        
        do {
            let theJSONData = try JSONSerialization.data(withJSONObject: data)
            
            let theJSONText = NSString(data: theJSONData, encoding: String.Encoding.ascii.rawValue)
            print("JSON string = \(theJSONText!)")
            
            return theJSONData
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
        
    }
}
