//
//  AppDelegate.swift


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let navigation = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigation
        navigation.isNavigationBarHidden = true
        
        return true
    }
//========================================================================
//========================================================================
                        /* SAVE FUNCTION */
                /* ================================ */
    static func save(time: Int, key: String) {
        UserDefaults.standard.set(time, forKey: key)
    }
    static func saveEditedValues() {
        save(time: TIMER_MINUTES, key: "TIMER_MINUTES")
        save(time: TIMER_SECONDS, key: "TIMER_SECONDS")
        save(time: SET_NUM, key: "SET_NUM")
        save(time: BREAK_MINUTES, key: "BREAK_MINUTES")
        save(time: BREAK_SECONDS, key: "BREAK_SECONDS")
    }
                        /* LOAD FUNCTION */
                /* ================================ */
    static func loadValueWithKey(key: String) -> Int {
        if let value = UserDefaults.standard.object(forKey: key) as? Int {
            return value
        }
        return 0
    }
    static func loadAllValues() {
        if let value1 = UserDefaults.standard.object(forKey: "TIMER_MINUTES") as? Int {
            TIMER_MINUTES = value1
        }
        if let value2 = UserDefaults.standard.object(forKey: "TIMER_SECONDS") as? Int {
            TIMER_SECONDS = value2
        }
        if let value3 = UserDefaults.standard.object(forKey: "SET_NUM") as? Int {
            SET_NUM = value3
        }
        if let value4 = UserDefaults.standard.object(forKey: "BREAK_MINUTES") as? Int {
            BREAK_MINUTES = value4
        }
        if let value5 = UserDefaults.standard.object(forKey: "BREAK_SECONDS") as? Int {
            BREAK_SECONDS = value5
        }
        if let value6 = UserDefaults.standard.object(forKey: "TOTAL_BREAK_TIME") as? Int {
            TOTAL_BREAK_TIME = value6
        }
        if let value7 = UserDefaults.standard.object(forKey: "TOTAL_TIME") as? Int {
            TOTAL_TIME = value7
        }

    }

}

