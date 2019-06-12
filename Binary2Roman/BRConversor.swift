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
    func convert(inputTextField: String, resultLable: UILabel) -> Bool {
        //TODO: Conversor logic
        if isBinary(inputText: inputTextField){
            resultLable.text = inputTextField
            return true
        } else if isRoman(inputText: inputTextField) {
            resultLable.text = inputTextField
            return true
        } else {
            return false
        }
    }
    
    func isBinary(inputText: String) -> Bool {
        var returnValue =  true
        let binaryRegularEx = "\\b[01]+\\b"
        
        do {
            let regex = try NSRegularExpression(pattern: binaryRegularEx)
            let nsString = inputText as NSString
            let results = regex.matches(in: inputText, range: NSRange(location: 0, length: nsString.length))
            
            if (results.count == 0) {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    func isRoman(inputText: String) -> Bool {
        let romanRegularEx = "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$"
        do {
            let regex = try NSRegularExpression(pattern: romanRegularEx)
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
