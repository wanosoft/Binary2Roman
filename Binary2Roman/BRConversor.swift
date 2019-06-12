//
//  BRConversor.swift
//  Binary2Roman
//
//  Created by David Arellano on 6/11/19.
//  Copyright © 2019 David Arellano. All rights reserved.
//
import UIKit
import Foundation

class BRConversor {
    
    let binaryRegularEx = "\\b[01]+\\b"
    let romanRegularEx = "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$"
    
    func convert(inputTextField: String, resultLable: UILabel) -> Bool {
        //TODO: Conversor logic
        if validateNumber(inputText: inputTextField, regularEx: binaryRegularEx){
            resultLable.text = binary2Decimal(inputText: inputTextField)
            return true
        } else if validateNumber(inputText: inputTextField, regularEx: romanRegularEx) {
            resultLable.text = roman2Binary(inputText: inputTextField)
            return true
        } else {
            return false
        }
    }
    
    func validateNumber(inputText: String, regularEx: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regularEx)
            let nsString = inputText as NSString
            let results = regex.matches(in: inputText, range: NSRange(location: 0, length: nsString.length))
            
            if (results.count == 0) {
                return false
            }
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func binary2Decimal(inputText: String) -> String {
        var number = Int(strtoul(inputText, nil, 2))
        let romans = ["M":1000,"CM":900,"D":500,"CD":400,"C":100,"XC":90,"L":50,"XL":40,"X":10,"IX":9,"V":5,"IV":4,"I":1]
        if number <= 0 || number >= 4000 { return "4000 MAX SUPPORTED" }
        var romanNumeral:String = ""
        
        for romanNumber in romans {
            while (number==romanNumber.value || number >= romanNumber.value){
                number -= romanNumber.value
                romanNumeral += romanNumber.key
            }
        }
        return romanNumeral
    }
    
    func roman2Binary(inputText: String) -> String {
        let romans = [" ":0, "I":1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]
        
        var previousValue = 0
        var summ = 0
        var letter = " "
        
        for inputNumber in inputText {
            letter = String(inputNumber)
            for romanNumber in romans {
                if letter == romanNumber.key {
                    summ =  summ + romanNumber.value
                    if previousValue < romanNumber.value {
                        summ = summ - previousValue*2
                        previousValue = romanNumber.value
                    } else {
                        previousValue = romanNumber.value
                    }
                }
            }
        }
        return String(summ, radix: 2)
    }
}

