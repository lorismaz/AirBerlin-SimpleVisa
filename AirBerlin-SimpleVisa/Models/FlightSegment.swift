//
//  FlightSegment.swift
//  AirBerlin-SimpleVisa
//
//  Created by Loris Mazloum on 11/11/16.
//  Copyright © 2016 Maz Labs. All rights reserved.
//
//    "direction": "onward",
//    "fs_id": "05a7f110-6f95-4ebc-a92e-111629381984",
//    "fare_code": "NNYOW",
//    "date": "2016-10-25",
//    "number": "30BOPC8MG_20BPRT6VA"

import Foundation

class FlightSegment {

    let direction: String
    let fareCode: String
    let date: String
    let number: String
    var fsId: String? = nil
    
    public init(direction: String, fareCode: String, date: String, number: String) {
        self.direction = direction
        self.fareCode = fareCode
        self.date = date
        self.number = number
    }
    
    func toJSON() -> Data? {
        let data = [ "data":
            [
                "direction": self.direction,
                "fare_code": self.fareCode,
                "date": self.date,
                "number": self.number
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
