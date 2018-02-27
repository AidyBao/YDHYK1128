//
//  String+ZXA.swift
//  YDHYK
//
//  Created by screson on 2017/10/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension String {
    public func index(at: Int) -> Index {
        return self.index(startIndex, offsetBy: at)
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = index(at: from)
        return substring(from: fromIndex)
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(at: to)
        return substring(to: toIndex)
    }
    
    public func substring(with r:Range<Int>) -> String {
        let startIndex  = index(at: r.lowerBound)
        let endIndex    = index(at: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}


extension String {
    public func zx_noticeName() -> NSNotification.Name {
        return NSNotification.Name.init(self)
    }
        
    public func zx_priceString(_ unit:Bool = true) -> String {
        var price = self
        if price.characters.count <= 0 {
            price = "0"
        }
        let location = (price as NSString).range(of: ".")
        if  location.length <= 0 {
            price += ".00"
        } else if (price.characters.count - 1 - location.location) < 2 {
            price += "0"
        }
        price = price.replacingOccurrences(of: "(?<=\\d)(?=(\\d\\d\\d)+(?!\\d))", with: ",", options: .regularExpression, range: price.startIndex..<price.endIndex)
        if unit {
            if !price.hasPrefix("¥") {
                return "¥\(price)"
            }
        } else {
            if price.hasPrefix("¥") {
                return price.substring(from: 1)
            }
        }
        
        return price
    }
}
