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
   
   //var userIsInTheMiddleOfTypingANumber:Bool =  false
   var userIsInTheMiddleOfTypingANumber =  false
   
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
      let operation = sender.currentTitle!
      if userIsInTheMiddleOfTypingANumber {
         enter()
      }
      switch operation {
      case "✖️": performOperation{$0 * $1}
      case "➗": performOperation{$1 / $0}
      case "➕": performOperation{$0 + $1}
      case "➖": performOperation{$1 - $0}
      case "✔️": performOperation{sqrt($0)}

      default:break
      }
      
   }
   
   func performOperation(operation: (Double, Double) -> Double){
      if operandStack.count >= 2 {
         displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
         enter()
      }
   }

   private func performOperation(operation: (Double) -> Double ){
      if operandStack.count >= 1 {
         displayValue = operation(operandStack.removeLast())
         enter()
      }
   }
   

   
   //var operandStack: Array<Double> = Array<Double>()
   var operandStack = Array<Double>()
   
   @IBAction func enter() {
      userIsInTheMiddleOfTypingANumber = false
      operandStack.append(displayValue)
      print("operandStack = \(operandStack)")
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

