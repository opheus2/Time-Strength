//
//  StartController.swift

import UIKit
import GoogleMobileAds
import AVFoundation

class StartController: UIViewController, GADBannerViewDelegate {
    
    var timer = Timer()
    var (leftMinutes, leftSeconds) = (TIMER_MINUTES, TIMER_SECONDS)
    var (leftBreakMinutes, leftBreakSeconds) = (BREAK_MINUTES, BREAK_SECONDS)
    var sets = SET_NUM
    var shouldHaveBreak = true
  //  var catch_breathe = "catch your breath"
//======================================================================
//======================================================================
    override func viewDidLoad() {
        setupViews()
        activateTimer(isActivated: true)
        launchAdMob(enable: ENABLE_ADMOB)
    }
//======================================================================
//======================================================================
    var timeLabelTopAnchor: CGFloat {
        get{
            return InfoView.isIphoneX() ? 200 : 100
        }
    }
    var timerRedImageTopAnchor: NSLayoutConstraint?
    func setupViews() {
        view.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
        
        view.addSubview(timerRedImageView)
        view.addSubview(timeLabel)
        view.addSubview(setLabel)
   //     view.addSubview(catchBreathe)
        view.addSubview(stopBtn)
        view.addSubview(pauseResumeBtn)
        view.addSubview(breakQuoteLabel)
        
        timerRedImageTopAnchor = timerRedImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        
        _ = timeLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: timeLabelTopAnchor, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 80)
        
        _ = setLabel.anchor(nil, left: view.leftAnchor, bottom: timeLabel.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
    //    _ = catchBreathe.anchor(nil, left: view.leftAnchor, bottom: timeLabel.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        _ = stopBtn.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 70, rightConstant: 40, widthConstant: 0, heightConstant: 45)
        
        _ = pauseResumeBtn.anchor(nil, left: view.leftAnchor, bottom: stopBtn.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 35, rightConstant: 40, widthConstant: 0, heightConstant: 45)
        
        _ = breakQuoteLabel.anchor(timeLabel.bottomAnchor, left: view.leftAnchor, bottom: pauseResumeBtn.topAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    //======================================================================
    //======================================================================
    var timerRedImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.hexColor(hex: RED_COLOR_HEX)
        return img
    }()
    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = String.showTwoDigits(num: TIMER_MINUTES) + ":" + String.showTwoDigits(num: TIMER_SECONDS)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: FONT_NAME, size: 70)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    let setLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "ROUNDS LEFT : \(SET_NUM)"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: FONT_NAME, size: 25)
        lbl.textColor = .white
        lbl.isHidden = true
        return lbl
    }()
    let pauseResumeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("PAUSE", for: .normal)
        btn.setTitleColor(.white , for: .normal)
        btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 45)
        btn.addTarget(self, action: #selector(pauseResumeLogic), for: .touchUpInside)
        return btn
    }()
    let stopBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("STOP", for: .normal)
        btn.setTitleColor(.white , for: .normal)
        btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 45)
        btn.addTarget(self, action: #selector(stopBtnLogic), for: .touchUpInside)
        return btn
    }()
    let breakQuoteLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "\(DEFAULT_BREAK_QUOTE_TEXT)"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: FONT_NAME, size: 30)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.isHidden = true
        return lbl
    }()
    
//======================================================================
    //======================================================================
    @objc func stopBtnLogic() {
        activateTimer(isActivated: false)
        dismiss(animated: true, completion: nil)
    }
    @objc func pauseResumeLogic() {
        if pauseResumeBtn.titleLabel?.text == "PAUSE" {
            activateTimer(isActivated: false)
            pauseResumeBtn.setTitle("RESUME", for: .normal)
            return
        }
        pauseResumeBtn.setTitle("PAUSE", for: .normal)
        activateTimer(isActivated: true)
    }
    //======================================================================
    //======================================================================
    var stopAnimating = false
    func activateTimer(isActivated: Bool) {
        if isActivated {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startDecreasingTime), userInfo: nil, repeats: true)
            return
        }
        timer.invalidate()
    }
    @objc func startDecreasingTime(){
        if !stopAnimating {
            intTime += 1
            animateRedBackground(withHeightPosition: calculateResultToPullRedBackgroundOutOfScreen())
        }
        
        if leftSeconds > 0 {
            leftSeconds -= 1
        } else if leftSeconds == 0 && leftMinutes > 0 {
            leftMinutes -= 1
            leftSeconds = 59
        } else {
            intTime = 0
            if stopAnimating == true {
                stopAnimating = false
                timerRedImageView.isHidden = false
                breakQuoteLabel.isHidden = true
            } else {
                stopAnimating = true
                breakQuoteLabel.isHidden = false
                timerRedImageView.isHidden = true
                UIView.animateToTop(element: timerRedImageView, y: 0, elementLayout: timerRedImageTopAnchor!)
            }
            decreaseSetsNumber()
            playSound(soundName: BELL_RING_SOUND, format: "wav")
            
        }
        timeLabel.text = String.showTwoDigits(num: leftMinutes) + ":" + String.showTwoDigits(num: leftSeconds)
    }
    func decreaseSetsNumber() {
        if sets > 0 {
            if shouldHaveBreak {
                breakTime(isOnBreak: true)
            } else {
                breakTime(isOnBreak: false)
                if sets == 1 {
                    shouldHaveBreak = false
                    sets = 0
                }
            }
        } else {
            // Everything has finished either to go back to the view or put congratulations thing
           activateTimer(isActivated: false)
            
            //self.present(InfoController(), animated: true, completion: nil)
            //dismiss(animated: true, completion: nil)
            stopBtn.setTitle("FINISH", for: .normal)
        
        }
        setLabel.text = "ROUNDS LEFT : \(sets)"
       // setLabel.text = "ROUNDS LEFT : \(sets)"
        //stopBtn.setTitle("FINISH", for: .normal)
    }
    
    func breakTime(isOnBreak: Bool) {
        //save
        if isOnBreak {
            sets -= 1
            TOTAL_TIME += (TIMER_MINUTES * 60) + TIMER_SECONDS
            (leftMinutes, leftSeconds) = (leftBreakMinutes, leftBreakSeconds)
            shouldHaveBreak = !isOnBreak
            setLabel.isHidden = !isOnBreak
            AppDelegate.save(time: TOTAL_TIME, key: "TOTAL_TIME")
            return
        }
        TOTAL_BREAK_TIME += ( BREAK_MINUTES * 60) + BREAK_SECONDS
        (leftMinutes, leftSeconds) = (TIMER_MINUTES, TIMER_SECONDS)
        shouldHaveBreak = !isOnBreak
        setLabel.isHidden = !isOnBreak
        AppDelegate.save(time: TOTAL_BREAK_TIME, key: "TOTAL_BREAK_TIME")
    }
    //======================================================================
    //======================================================================
    var intTime:CGFloat = 0
    func calculateScreenHeight() -> Float {
        return Float(UIScreen.main.bounds.height)
    }
    func calculateResultToPullRedBackgroundOutOfScreen() -> CGFloat {
        let result = Float(calculateScreenHeight()) / ((Float(TIMER_MINUTES) * 60.0) + Float(TIMER_SECONDS))
        return CGFloat(result)
    }
    func animateRedBackground(withHeightPosition y: CGFloat) {
        let newPos = y * intTime
        timerRedImageTopAnchor?.constant = newPos
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    //======================================================================
    //======================================================================
    /* AdMob Functions */
    /*===================================*/
    var admobInterstitial : GADInterstitial?
    var AdTimer: Timer?
    lazy var bannerView:GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = ADMOB_BANNER_ID
        banner.rootViewController = self
        banner.delegate = self
        banner.load(GADRequest())
        banner.layer.zPosition = 2
        
        return banner
    }()
    func createAndLoadInterstitial()-> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: ADMOB_INTERSTITIAL_ID)
        interstitial.load(GADRequest())
        return interstitial
    }
    @objc func presentInterstitial() {
        if (admobInterstitial?.isReady) != nil {
            admobInterstitial?.present(fromRootViewController: self)
        }
    }
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        //print("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        admobInterstitial = createAndLoadInterstitial()
    }
    func tryLunchInterstitialAds() {
        admobInterstitial = createAndLoadInterstitial()
        AdTimer = Timer.scheduledTimer(timeInterval: 2.0, target:self, selector: #selector(presentInterstitial), userInfo: nil, repeats: false)
    }
    func launchAdMob(enable: Bool) {
        if enable {
            view.addSubview(bannerView)
            _ = bannerView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        }
    }
    //======================================================================
    //======================================================================
    /* Play Sound Functions */
    /*===================================*/
    var player:AVAudioPlayer = AVAudioPlayer()
    func playSound(soundName: String, format: String) {
        let path = Bundle.main.path(forResource: soundName, ofType: format)
        let soundUrl = URL(fileURLWithPath: path!)
        do {
            try player = AVAudioPlayer(contentsOf: soundUrl)
            player.prepareToPlay()
            player.play()
        }catch{
            //It didn't work playing sound
        }
    }
    //======================================================================
    //======================================================================
    
}





