//
//  InfoView.swift


import UIKit

class InfoView: UIView {
    
//======================================================================
//======================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//======================================================================
//======================================================================
    func setupViews() {
        addSubview(backgroundImage)
        addSubview(blackBackgroundForTotalTime)
        addSubview(blackBackgroundForTotalBreakTime)
        addSubview(blackBackgroundForShare)
        addSubview(totalTimeLabel)
        addSubview(actualTotalTimeLabel)
        addSubview(totalBreakTimeLabel)
        addSubview(actualTotalBreakTimeLabel)
        addSubview(shareLabel)
        
        _ = backgroundImage.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        _ = blackBackgroundForTotalTime.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 150, leftConstant: 35, bottomConstant: 0, rightConstant: 35, widthConstant: 0, heightConstant: 120)
        _ = blackBackgroundForTotalBreakTime.anchor(blackBackgroundForTotalTime.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 125)
        _ = blackBackgroundForShare.anchor(blackBackgroundForTotalBreakTime.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 125)
        
        _ = totalTimeLabel.anchor(blackBackgroundForTotalTime.topAnchor, left: blackBackgroundForTotalTime.leftAnchor, bottom: nil, right: blackBackgroundForTotalTime.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        _ = actualTotalTimeLabel.anchor(totalTimeLabel.bottomAnchor, left: blackBackgroundForTotalTime.leftAnchor, bottom: blackBackgroundForTotalTime.bottomAnchor, right: blackBackgroundForTotalTime.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = totalBreakTimeLabel.anchor(blackBackgroundForTotalBreakTime.topAnchor, left: blackBackgroundForTotalBreakTime.leftAnchor, bottom: nil, right: blackBackgroundForTotalBreakTime.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        _ = actualTotalBreakTimeLabel.anchor(totalBreakTimeLabel.bottomAnchor, left: blackBackgroundForTotalBreakTime.leftAnchor, bottom: blackBackgroundForTotalBreakTime.bottomAnchor, right: blackBackgroundForTotalBreakTime.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = shareLabel.anchor(blackBackgroundForShare.topAnchor, left: blackBackgroundForShare.leftAnchor, bottom: nil, right: blackBackgroundForShare.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
//======================================================================
//======================================================================
    let backgroundImage: UIImageView = {
        let img = UIImageView()
        let image = UIImage(named: INFO_BACKGROUND_IMAGE)
            img.image = image
            img.contentMode = .scaleAspectFill
        return img
    }()
    let blackBackgroundForTotalTime: UIView = {
        let bg = UIView()
            bg.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
            bg.layer.borderColor = UIColor.white.cgColor
            bg.layer.borderWidth = 1
            bg.layer.cornerRadius = 13

        return bg
    }()
    let totalTimeLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "TOTAL TIME :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
        return lbl
    }()
    let actualTotalTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "00:00:00"//"\(TOTAL_TIME)"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 50)
            lbl.textColor = .white
        return lbl
    }()
    let blackBackgroundForTotalBreakTime: UIView = {
        let bg = UIView()
            bg.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
            bg.layer.borderColor = UIColor.white.cgColor
            bg.layer.borderWidth = 1
            bg.layer.cornerRadius = 13
        return bg
    }()
    let totalBreakTimeLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "TOTAL BREAKS :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
        return lbl
    }()
    let actualTotalBreakTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "00:00:00"//"\(TOTAL_BREAK_TIME)"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 50)
            lbl.textColor = .white
        return lbl
    }()
    let blackBackgroundForShare: UIView = {
        let bg = UIView()
            bg.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
            bg.layer.borderColor = UIColor.white.cgColor
            bg.layer.borderWidth = 1
            bg.layer.cornerRadius = 13

        return bg
    }()
    let shareLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "SHARE :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
        return lbl
    }()
//======================================================================
//======================================================================
    static func isIphoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                return true
            }
        }
        return false
    }
    
}














