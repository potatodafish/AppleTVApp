//
//  NumberCard.swift
//  AppleTVGame
//
//  Created by Guilherme Vassallo on 13/09/2018.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import Foundation
import SpriteKit

typealias Rational = (num : Int, den : Int)

public class NumberCard {
    
    var cardBG: UIImage!
    var numberValue: Float!
    var numberDisplay: String?
    let numberFormatter = NumberFormatter()
    
    
    func setDigits(numOfDigits: Int, value: Float) -> String?{
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = numOfDigits
        numberFormatter.roundingMode = .down
        
        let formatedValue = numberFormatter.string(from: (NSNumber(value: value)))
        return formatedValue
    }
    
    func setPercentageDigits(numOfDigits: Int, value: Float) -> String?{
        let newValue = value*100
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = numOfDigits
        numberFormatter.roundingMode = .down
        
        let formatedValue = numberFormatter.string(from: (NSNumber(value: newValue)))
        return formatedValue
    }
    
    
    func convertNumber(value: Float){
        let possibility = arc4random_uniform(3) + 1
        
        switch possibility {
        case 1: //só mostra o número como o valor decimal. Update: Indo
            let formattedValue = setDigits(numOfDigits: 2, value: value)
            self.numberDisplay = formattedValue
            
        case 2: //mostra número como porcentagem.
            let formattedValue = setPercentageDigits(numOfDigits: 0, value: value)!
            let cardString = "\(String(describing: formattedValue))%"
            self.numberDisplay = cardString
            
            //print("\(String(describing: self.numberDisplay))")
            
        case 3: //mostra o número como fração
            
            numberFormatter.string(from: NSNumber(value: value))
            var fraction: Rational
            
            fraction = rationalApproximation(of: Double(numberValue))
            
            let cardString = "\(fraction.num)/\(fraction.den)"
            self.numberDisplay = cardString
            
        default:
            self.numberDisplay = "U DONE F****** IT UP"
        }
    }
    
    
    
    func changeBG (correct: Bool){
        if correct == true{
            self.cardBG = UIImage(named: "card_correto")
        }
        else{
            self.cardBG = UIImage(named: "card_errado")
        }
    }
    
    func resetBG () {
        self.cardBG = UIImage(named: "card_neutro")
    }
    
    
    
    init(cardBG: UIImage, numberValue: Float){
        self.cardBG = cardBG
        self.numberValue = numberValue
    }
    
}




//essa função não faz parte da classe

func rationalApproximation(of x0 : Double, withPrecision eps : Double = 1.0E-2) -> Rational {
    var x = x0
    var a = x.rounded(.down)
    var (h1, k1, h, k) = (1, 0, Int(a), 1)
    
    while x - a > eps * Double(k) * Double(k) {
        x = 1.0/(x - a)
        a = x.rounded(.down)
        (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
    }
    return (h, k)
}