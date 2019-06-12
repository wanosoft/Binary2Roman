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
            resultLable.text = inputTextField
            return true
        } else if validateNumber(inputText: inputTextField, regularEx: romanRegularEx) {
            resultLable.text = inputTextField
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
}
