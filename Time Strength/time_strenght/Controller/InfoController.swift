//
//  InfoController.swift


import UIKit
import Social

var TOTAL_TIME = 0
var TOTAL_BREAK_TIME = 0

class InfoController: UIViewController {
    
//======================================================================
//======================================================================
    override func viewDidLoad() {
        setupViews()
        updateValues()
    }
//======================================================================
//======================================================================
    func setupViews() {
        view.addSubview(infoUIView)
        view.addSubview(backButton)
        view.addSubview(facebookButton)
        view.addSubview(twitterButton)
        
        _ = infoUIView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        _ = backButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 35)
        
        _ = facebookButton.anchor(infoUIView.shareLabel.bottomAnchor, left: infoUIView.blackBackgroundForShare.leftAnchor, bottom: infoUIView.blackBackgroundForShare.bottomAnchor, right: nil, topConstant: 5, leftConstant: 50, bottomConstant: 10, rightConstant: 0, widthConstant: 100, heightConstant: 40)
        
        _ = twitterButton.anchor(infoUIView.shareLabel.bottomAnchor, left: nil, bottom: infoUIView.blackBackgroundForShare.bottomAnchor, right: infoUIView.blackBackgroundForShare.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 50, widthConstant: 100, heightConstant: 40)
    }
    let infoUIView: InfoView = {
       let view = InfoView()
        return view
    }()
    let backButton: UIButton = {
        let btn = UIButton()
            btn.setTitle("BACK", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 30)
        btn.addTarget(self, action: #selector(backBtnLogic), for: .touchUpInside)
        return btn
    }()
    let facebookButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "fbLogo"), for: .normal)
        btn.addTarget(self, action: #selector(shareOnFacebook), for: .touchUpInside)
        return btn
    }()
    let twitterButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "twitterLogo"), for: .normal)
        btn.addTarget(self, action: #selector(shareOnTwitter), for: .touchUpInside)
        
        return btn
    }()
//======================================================================
//======================================================================
                        /*  Button Functions */
                /* =================================*/
    @objc func backBtnLogic() {
        _ = navigationController?.popViewController(animated: true)
        
    }
    @objc func shareOnFacebook() {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let fbShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.setInitialText(SOCIAL_SHARE_MESSAGE)
            fbShare.add(UIImage(named: SOCIAL_MEDIA_IMAGE))
            self.present(fbShare, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please login to your account !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func shareOnTwitter() {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let TwShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            TwShare.setInitialText(SOCIAL_SHARE_MESSAGE)
            TwShare.add(UIImage(named: SOCIAL_MEDIA_IMAGE))
            self.present(TwShare, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please login to your account !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
//======================================================================
//======================================================================
    func updateValues() {
       let (h,m,s) = CoreFunction.secondsToHoursMinutesSeconds(seconds: TOTAL_TIME)
        infoUIView.actualTotalTimeLabel.text = String.showTwoDigits(num: h) + ":" + String.showTwoDigits(num: m) + ":" + String.showTwoDigits(num: s)
        
        let (h1,m1,s1) = CoreFunction.secondsToHoursMinutesSeconds(seconds: TOTAL_BREAK_TIME)
        infoUIView.actualTotalBreakTimeLabel.text = String.showTwoDigits(num: h1) + ":" + String.showTwoDigits(num: m1) + ":" + String.showTwoDigits(num: s1)
        
    }
    
}
