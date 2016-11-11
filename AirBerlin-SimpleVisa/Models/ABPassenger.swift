//
//  ABPassenger.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//
//"type": "ADT",
//"salutation": "MR",
//"first_name": "Loris",
//"last_name": "Mazloumi",
//"p_id": "ac6b3321-6d33-4c94-b21a-6c5b0d5370d4",
//"date_of_birth": "1983-06-29"

import Foundation

enum ABPassengerType: String {
    case adult = "ADT"
    case child = "CLD"
}

class ABPassenger {
    let type: ABPassengerType
    let salutation: String
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    var pId: String? = nil
    
    public init(type: ABPassengerType, salutation: String, firstName: String, lastName: String, dateOfBirth: String) {
        self.type = type
        self.salutation = salutation
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
    }
    
    func toJSON() -> Data? {
        let data = [ "data":
            [
                "type": self.type.rawValue,
                "salutation": self.salutation,
                "first_name": self.firstName,
                "last_name": self.lastName,
                "date_of_birth": self.dateOfBirth
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
