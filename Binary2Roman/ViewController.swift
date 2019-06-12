//
//  ViewController.swift
//  Binary2Roman
//
//  Created by David Arellano on 6/11/19.
//  Copyright © 2019 David Arellano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    // UI Outlet Components
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet var tittleLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(
            target: self.view, action: #selector(UIView.endEditing(_:))))
        self.inputTextField.delegate = self
        self.inputTextField.autocapitalizationType = .allCharacters
        self.inputTextField.autocorrectionType = .no
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //Change values when is changed: Clean textfield and resultLabel and close keyboard
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        if(segmentedControl.selectedSegmentIndex == 0){ // binary 2 roman
            tittleLabel.text = "Binary 2 Roman"
            instructionLabel.text = "Insert a BINARY number"
            inputTextField.text = ""
            inputTextField.placeholder = "10010101101"
            resultLabel.text = "Result"
            self.view.endEditing(true)
            inputTextField.keyboardType = UIKeyboardType.decimalPad
            
        } else { // roman 2 binary
            tittleLabel.text = "Roman 2 Binary"
            instructionLabel.text = "Insert a ROMAN number"
            inputTextField.text = ""
            inputTextField.placeholder = "MCMXCVI"
            resultLabel.text = "Result"
            self.view.endEditing(true)
            inputTextField.keyboardType = UIKeyboardType.alphabet
        }
    }
    
    // Execute the converter logic.
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        // TODO: Implement Conversor
        if (inputTextField.text!.isEmpty){
            invalidInput()
        } else {
            BRConversor.init().convert(
                inputTextField: inputTextField.text!,
                resultLable: resultLabel) ? print("Ok") : invalidInput()
        }
    }
    
    // invalid Input Alert
    func invalidInput() {
        let alert = UIAlertController(title: "Oops!", message: "Enter a valid number", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "OK"), style: .default, handler: { _ in
            NSLog("The user probably tries again.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // TextField Delegate Method: Helps to manage the suitable character set per operation (binary & roman)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var allowedCharacters = CharacterSet.uppercaseLetters
        
        if segmentedControl.selectedSegmentIndex == 0 { allowedCharacters = CharacterSet.decimalDigits
        } else { allowedCharacters = CharacterSet.uppercaseLetters }
        
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

