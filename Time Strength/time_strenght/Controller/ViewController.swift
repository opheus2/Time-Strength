//
//  ViewController.swift


import UIKit
import GoogleMobileAds

var TIMER_MINUTES = 0
var TIMER_SECONDS = 6

var SET_NUM = 3

var BREAK_MINUTES = 0
var BREAK_SECONDS = 5

class ViewController: UIViewController, GADBannerViewDelegate {
    
//======================================================================
//======================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.loadAllValues()
        setupViews()
        launchAdMob(enable: ENABLE_ADMOB)
        //tryLunchInterstitialAds()
    }
    override func viewDidAppear(_ animated: Bool) {
        updateDefaultLabels()
    }
//======================================================================
//======================================================================
    var editInfoButtonTopAnchor: CGFloat {
        get{
            return InfoView.isIphoneX() ? 50 : 30
        }
    }
    var timeLabelTopAnchor: CGFloat {
        get{
            return InfoView.isIphoneX() ? 150 : 100
        }
    }
    func setupViews() {
        view.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
        
        view.addSubview(editBtn)
        view.addSubview(infoBtn)
        view.addSubview(timeLabel)
        view.addSubview(setLabel)
        view.addSubview(breakLabel)
        view.addSubview(startBtn)
        
        _ = editBtn.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: editInfoButtonTopAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 40)
        
        _ = infoBtn.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: editInfoButtonTopAnchor - 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        _ = timeLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: timeLabelTopAnchor, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 100)
        
        _ = setLabel.anchor(timeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 41, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 100)
        
        _ = breakLabel.anchor(setLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 41, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 100)
        
        _ = startBtn.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 70, rightConstant: 30, widthConstant: 0, heightConstant: 60)
    }
//======================================================================
//======================================================================
                        /*  UIView Elemets */
                /* =================================*/
    let editBtn: UIButton = {
       let btn = UIButton()
            btn.setTitle("EDIT", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 35)
            btn.addTarget(self, action: #selector(editBtnLogic), for: .touchUpInside)
        return btn
    }()
    
    let infoBtn: UIButton = {
        let btn = UIButton()
        var img = UIImage(named: "cup1")
            btn.setImage(img, for: .normal)
            btn.addTarget(self, action: #selector(infoBtnLogic), for: .touchUpInside)
        return btn
    }()
    let timeLabel: UILabel = {
       let lbl = UILabel()
            lbl.text = "TIME\n" + String.showTwoDigits(num: TIMER_MINUTES) + ":" + String.showTwoDigits(num: TIMER_SECONDS)
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let setLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "ROUNDS\n" + String(SET_NUM)
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let breakLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "BREAKS\n" + String.showTwoDigits(num: BREAK_MINUTES) + ":" + String.showTwoDigits(num: BREAK_SECONDS)
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let startBtn: UIButton = {
        let btn = UIButton()
            btn.setTitle("START", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 50)
            btn.addTarget(self, action: #selector(startBtnLogic), for: .touchUpInside)
        return btn
    }()
//======================================================================
//======================================================================
                        /*  Button Functions */
                /* =================================*/
    @objc func editBtnLogic() {
        perform(#selector(showEditView))
    }
    @objc func infoBtnLogic() {
        navigationController?.pushViewController(InfoController(), animated: true)
    }
    @objc func startBtnLogic() {
        present(StartController(), animated: true, completion: nil)
    }
//======================================================================
//======================================================================
    @objc func showEditView() {
        let editController = EditController()
        //present(editController, animated: true, completion: nil)
        navigationController?.pushViewController(editController, animated: true)
    }
    func updateDefaultLabels() {
        timeLabel.text = "TIME\n" + String.showTwoDigits(num: TIMER_MINUTES) + ":" + String.showTwoDigits(num: TIMER_SECONDS)
        setLabel.text = "ROUNDS\n" + String(SET_NUM)
        breakLabel.text = "BREAKS\n" + String.showTwoDigits(num: BREAK_MINUTES) + ":" + String.showTwoDigits(num: BREAK_SECONDS)
    }
//======================================================================
//======================================================================
   // func launchAdMob(enable: Bool) {
     //   if enable {
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
    func createAndLoadInterstitial()->GADInterstitial {
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
        AdTimer = Timer.scheduledTimer(timeInterval: 3.0, target:self, selector: #selector(presentInterstitial), userInfo: nil, repeats: false)
    }

    func launchAdMob(enable: Bool) {
        if enable {
            view.addSubview(bannerView)
            _ = bannerView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        }
    }
//======================================================================
//======================================================================
    
    
}

