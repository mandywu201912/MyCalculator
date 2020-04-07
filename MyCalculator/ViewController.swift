//
//  ViewController.swift
//  MyCalculator
//
//  Created by Riva WU on 2020/4/7.
//  Copyright © 2020 whale miracle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
       var number1:Double? //第一次輸入的數值
       var number2:Double? //點選計算符號後的數值
       var operationSign:String? //計算符號
       var result:Double? //計算結果
       var typing:Bool = false //狀態是否正在輸入
       var equalPressed:Bool = false //是否按下等於鍵
       var currentOperationBtn: UIButton? //記錄點選的計算符號
       
       var input: Double {
           get{ //當input被「讀取」時，會直接抓目前Label上顯示的數字
               return Double(label.text!)!
           }
           set{ //當input被「設定」時，會把設定的值顯示在Label上
               label.text = "\(formatDecimal(num: newValue))"
               typing = false
           }
       }
       
       func formatDecimal (num: Double) -> String {
           var formatNum = ""
           if num != 0 {
               if num.truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.0f", num)
               }else if (num * 10).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.1f", num)
               }else if (num * 100).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.2f", num)
               }else if (num * 1000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.3f", num)
               }else if (num * 10000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.4f", num)
               }else if (num * 100000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.5f", num)
               }else if (num * 1000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.6f", num)
               }else if (num * 10000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.7f", num)
               }else if (num * 100000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.8f", num)
               }else if (num * -1).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.0f", num)
               }else if (num * -10).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.1f", num)
               }else if (num * -100).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.2f", num)
               }else if (num * -1000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.3f", num)
               }else if (num * -10000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.4f", num)
               }else if (num * -100000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.5f", num)
               }else if (num * -1000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.6f", num)
               }else if (num * -10000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.7f", num)
               }else if (num * -100000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                   formatNum =  String(format: "%.8f", num)
               }else {
                   formatNum = String(format: "%.10f", num)
               }
           }else {
               formatNum = "0"
           }
           
           return formatNum
       }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        let number = sender.currentTitle! //取得點選的數值
        if typing == true  { //還在輸入數值時，新輸入的數值直接放在後面
            label.text = label.text! + number
        } else { //第一次輸入時
            if number != "0" { //第一次輸入的不是0
            label.text = number
            typing = true
            } else { //第一次輸入的是0
                label.text = "0"
                typing = false
                       
            }
        }
    }
    
    //計算加減乘除的function
    func operation(num1:Double, num2:Double) -> Double {
        switch operationSign {
            
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "X":
            result = num1 * num2
        case "÷":
            result = num1 / num2
        
        default:
            break
        }
        
        return result!
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        typing = false //已經輸入結束
        var temResult: Double = 0
        
        if !equalPressed  { //如果沒有點選過 =
            if operationSign != nil { //且計算符號不為空
                number2 = input
                temResult = operation(num1: number1 ?? 0, num2: number2 ?? 0)
                input = temResult
                equalPressed = true
            }
        } else { //如果有點選過 =
            number1 = input
            temResult = operation(num1: number1 ?? 0, num2: number2 ?? 0)
            input = temResult
            
        }
        
        currentOperationBtn = sender
        
    }
    @IBAction func OperationButtons(_ sender: UIButton) {
        if !equalPressed { //如果沒有點選過 = 就進入計算
            if operationSign == nil { //如果之前沒點選過計算符號
                operationSign = sender.currentTitle!
                number1 = input
                typing = false //且輸入完成
                if operationSign == "%" {
                    var temResult: Double = 0
                    operationSign! = "÷"
                    number2 = Double(100)
                    temResult = operation(num1: number1 ?? 0, num2: number2 ?? 0)
                    input = temResult
                    number1 = input
                    number2 = nil
                    operationSign = nil
                }
            } else { //如果之前有點選過計算符號
                typing = false
                var temResult: Double = 0
                if operationSign == "%" {
                    var temResult: Double = 0
                    operationSign! = "÷"
                    number2 = Double(100)
                    temResult = operation(num1: number1 ?? 0, num2: number2 ?? 0)
                    input = temResult
                    number1 = input
                    number2 = nil
                    operationSign = nil
                
                } else { //如果不是點選%
                    number2 = input
                    temResult = operation(num1: number1 ?? 0, num2: number2 ?? 0)
                    input = temResult
                    operationSign = sender.currentTitle!
                    number1 = input
                }
            }
        } else { //如果有按過 ＝
            operationSign = sender.currentTitle!
            number1 = input
            typing = false
            equalPressed = false
            
        }
    }
    
    @IBAction func ACButton(_ sender: UIButton) {
        input = 0
        result = 0
        number1 = nil
        number2 = nil
        operationSign = nil
        equalPressed = false
        typing = false
    }
    
    
    @IBAction func DeleteLast(_ sender: UIButton) {
        if label.text?.count == 1 {
            label.text = " "
        } else {
            result = Double(label.text!.dropLast())!
            input = result!
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

