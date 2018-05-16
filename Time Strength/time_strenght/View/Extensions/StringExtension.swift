//
//  StringExtension.swift


import Foundation

extension String {
    
    static func showTwoDigits(num:Int) -> String {
        return String(format : "%02d",num)
    }
}
