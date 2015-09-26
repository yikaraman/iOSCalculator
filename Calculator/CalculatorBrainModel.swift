//
//  CalculatorBrainModel.swift
//  Calculator
//
//  Created by Yigit ilker Karamanli on 9/26/15.
//  Copyright © 2015 yikaraman. All rights reserved.
//

import Foundation

class CalculatorBrainModel {
   
   private enum Op{
      case Operand(Double)
      case UnaryOperation(String, Double -> Double)
      case BinaryOperation(String, (Double, Double) -> Double)
   }
   
   private var opStack = [Op]()
   
   private var knownOps = [String:Op]()
   
   init(){
      knownOps["×"] = Op.BinaryOperation("×", *)
      knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
      knownOps["+"] = Op.BinaryOperation("+", +)
      knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
      knownOps["√"] = Op.UnaryOperation("√", sqrt)
   }
   
   private func evaluate(ops:[Op]) -> (result:Double?, remainingOps:[Op]) {
      
      if !ops.isEmpty {
         var remainingOps = ops
         let op = remainingOps.removeLast()
         switch op{
         case .Operand(let operand):
            return (operand, remainingOps)
         case .UnaryOperation(_, let operation):
            let operandEveluation = evaluate(remainingOps)
            if let operand = operandEveluation.result {
               return(operation(operand), operandEveluation.remainingOps)
            }
         case .BinaryOperation(_, let operation):
            let op1Evaluation = evaluate(remainingOps)
            if let operand1 = op1Evaluation.result{
               let op2Evaluation = evaluate(op1Evaluation.remainingOps)
               if let operand2 = op2Evaluation.result{
               return(operation(operand1,operand2), op2Evaluation.remainingOps)
               }
            }
         }
      }
      return(nil,ops)
   }
   
   func evaluate() -> Double? {
      let (result,remainder) = evaluate(opStack)
      return result
   }
   
   func pushOperand(operand: Double){
      opStack.append(Op.Operand(operand))
   }
   
   func performOperation(symbol:String){
      if let operation = knownOps[symbol]{
         opStack.append(operation)
      }
      
   }
   
}