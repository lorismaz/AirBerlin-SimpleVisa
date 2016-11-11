//
//  CreditCard.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//
//{
//    "cc_id": "34638eba-b33d-4513-8b1d-5e2851ee5ddd",
//    "number": "4111111111111111",
//    "type": "VI",
//    "holders_name": "Loris Mazloum",
//    "cvc": "123",
//    "expiry_date": "2020-08-12"
//}

import Foundation

enum CreditCardType: String {
    case visa = "VI"
}

class CreditCard {
    let number: String
    let type: CreditCardType
    let holdersName: String
    let cvc: String
    let expiryDate: String
    var ccId: String? = nil
    
    public init(number: String, type: CreditCardType, holdersName: String, cvc: String, expiryDate: String) {
        self.number = number
        self.type = type
        self.holdersName = holdersName
        self.cvc = cvc
        self.expiryDate = expiryDate
    }
    
    func toJSON() -> Data? {
        let data = [ "data":
            [
                "number": self.number,
                "type": self.type.rawValue,
                "holders_name": self.holdersName,
                "cvc": self.cvc,
                "expiry_date": self.expiryDate
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
