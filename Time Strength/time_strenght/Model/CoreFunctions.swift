//
//  CoreFunctions.swift


import Foundation

class CoreFunction {
    
    static func didTimerEnd(minutes: Int, seconds: Int) -> Bool {
        if seconds == 0 && minutes == 0 {
            return true
        }
        return false
    }
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}
