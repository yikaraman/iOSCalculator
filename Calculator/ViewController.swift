//
//  ViewController.swift
//  Calculator
//
//  Created by Yigit ilker Karamanli on 9/13/15.
//  Copyright © 2015 yikaraman. All rights reserved.
//

import UIKit

class ViewController : UIViewController
{
   
   @IBOutlet weak var display: UILabel!
   
   var userIsInTheMiddleOfTypingANumber =  false
   var brain = CalculatorBrainModel()
   
   @IBAction func appendDigit(sender: UIButton) {
      // let means it is a constant
      let digit = sender.currentTitle!
      if userIsInTheMiddleOfTypingANumber {
         display.text = display.text! + digit
      }else{
         display.text = digit
         userIsInTheMiddleOfTypingANumber = true
      }
   }
   
   @IBAction func operate(sender: UIButton) {
      if userIsInTheMiddleOfTypingANumber {
         enter()
      }
      if let operation = sender.currentTitle {
         if let result = brain.performOperation(operation) {
            displayValue = result
         }else {
            displayValue = 0
         }
      }
   }
   
   @IBAction func enter() {
      userIsInTheMiddleOfTypingANumber = false
      if let result = brain.pushOperand(displayValue){
         displayValue = result
      } else {
         displayValue = 0
      }
   }
   
   var displayValue: Double {
      get{
         return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
      }
      set{
         display.text = "\(newValue)"
         userIsInTheMiddleOfTypingANumber = false
      }
   }
}

