//
//  EditController.swift


import UIKit

class EditController: UIViewController {

//======================================================================
//======================================================================
    override func viewDidLoad() {
        setupViews()
        fetchingDefaultValues()
        observerKeyboardNotification()
    }
//======================================================================
//======================================================================
    func setupViews() {
        view.backgroundColor = UIColor.hexColor(hex: "#10A4E4")
        
        view.addSubview(xBtn)
        view.addSubview(saveBtn)
        view.addSubview(timeLabel)
        view.addSubview(setLabel)
        view.addSubview(breakLabel)
        view.addSubview(seperatorLine)
        view.addSubview(breakQuoteLabel)
        view.addSubview(breakQuoteTextView)
        
        _ = xBtn.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 40, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 50)
        
        _ = saveBtn.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 90, heightConstant: 40)
        
        _ = timeLabel.anchor(xBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 50, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 50)
        
        _ = setLabel.anchor(timeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 50)
        
        _ = breakLabel.anchor(setLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 50)
        
        _ = seperatorLine.anchor(breakLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 5)
        
        _ = breakQuoteLabel.anchor(seperatorLine.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)

        _ = breakQuoteTextView.anchor(breakQuoteLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 100)
        
        setupViewsForTextViews()
        
    }
    var textViewArray = [UITextView]()
    func setupViewsForTextViews() {
        textViewArray = createTextView(withTag: 5)
        let (timeMinutesTextView, timeSecondsTextView) = (textViewArray[0], textViewArray[1])
        let (breakMinutesTextView, breakSecondsTextView) = (textViewArray[3],textViewArray[4])
        let setTextView = textViewArray[2]
        
        view.addSubview(timeSecondsTextView)
        view.addSubview(doublePoint)
        view.addSubview(timeMinutesTextView)
        view.addSubview(setTextView)
        view.addSubview(breakSecondsTextView)
        view.addSubview(doublePoint1)
        view.addSubview(breakMinutesTextView)
        
        _ = timeSecondsTextView.anchor(saveBtn.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 60, heightConstant: 50)
        _ = doublePoint.anchor(saveBtn.bottomAnchor, left: nil, bottom: nil, right: timeSecondsTextView.leftAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 50)
        _ = timeMinutesTextView.anchor(saveBtn.bottomAnchor, left: nil, bottom: nil, right: doublePoint.leftAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
        
        _ = setTextView.anchor(doublePoint.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 70, widthConstant: 30, heightConstant: 70)
        
        _ = breakSecondsTextView.anchor(setTextView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 60, heightConstant: 50)
        _ = doublePoint1.anchor(setTextView.bottomAnchor, left: nil, bottom: nil, right: breakSecondsTextView.leftAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 50)
        _ = breakMinutesTextView.anchor(setTextView.bottomAnchor, left: nil, bottom: nil, right: doublePoint1.leftAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
    }
//======================================================================
//======================================================================
                        /*  UIView Elemets */
                /* =================================*/
    let xBtn: UIButton = {
        let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.setTitle("X", for: .normal)
            btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 45)
            btn.addTarget(self, action: #selector(xBtnLogic), for: .touchUpInside)
        return btn
    }()
    let saveBtn: UIButton = {
        let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.setTitle("SAVE", for: .normal)
            btn.titleLabel?.font = UIFont(name: FONT_NAME, size: 35)
            btn.addTarget(self, action: #selector(saveBtnLogic), for: .touchUpInside)
        return btn
    }()
    let timeLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "TIME :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let setLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "ROUNDS :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let breakLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "BREAK :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let seperatorLine: UIView = {
        let line = UIView()
            line.backgroundColor = .white
        return line
    }()
    let breakQuoteLabel: UILabel = {
        let lbl = UILabel()
            lbl.text = "BREAK QUOTE :"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
            lbl.numberOfLines = 0
        return lbl
    }()
    let breakQuoteTextView: UITextView = {
       let tv = UITextView()
            tv.text = DEFAULT_BREAK_QUOTE_TEXT
            tv.backgroundColor = .white
            tv.layer.cornerRadius = 14
            tv.font = UIFont(name: FONT_NAME, size: 20)
        return tv
    }()
    let doublePoint: UILabel = {
       let lbl = UILabel()
            lbl.text = ":"
            lbl.textAlignment = .center
            lbl.font = UIFont(name: FONT_NAME, size: 40)
            lbl.textColor = .white
        return lbl
    }()
    let doublePoint1: UILabel = {
        let lbl = UILabel()
        lbl.text = ":"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: FONT_NAME, size: 40)
        lbl.textColor = .white
        return lbl
    }()
    // The TextViews are programmatically generated through a function at the end of this file
//======================================================================
//======================================================================
                        /*  Button Functions */
                /* =================================*/
    @objc func xBtnLogic() {
        _ = navigationController?.popViewController(animated: true)
    }
    @objc func saveBtnLogic() {
        guard Int(textViewArray[0].text) != nil, Int(textViewArray[2].text) != nil, Int(textViewArray[3].text) != nil else { return    }
        guard let timerSeconds = Int(textViewArray[1].text), timerSeconds < 60 , let breakSeconds = Int(textViewArray[4].text), breakSeconds < 60 else { return }
        
        
        let min = Int(textViewArray[0].text)!, sec = Int(textViewArray[1].text)!
        let break_min = Int(textViewArray[3].text)!, break_sec = Int(textViewArray[4].text)!
        let set = Int(textViewArray[2].text)!
        
        (TIMER_MINUTES, TIMER_SECONDS) = (min, sec)
        SET_NUM = set
        (BREAK_MINUTES, BREAK_SECONDS) = (break_min, break_sec)
        AppDelegate.saveEditedValues()
        
        navigationController?.popViewController(animated: true)
        // save
    }
//======================================================================
//======================================================================
                /*  Creating TextView Programmatically Functions */
                /* =============================================*/
    func createTextView(withTag tag:Int) -> [UITextView] {
        var textViewArray = [UITextView]()
        
        for x in 0..<tag {
        let tv = UITextView()
        tv.text = "00"
        tv.textAlignment = .center
        tv.backgroundColor = .black
        tv.font = UIFont(name: FONT_NAME, size: 40)
        tv.textColor = .white
        tv.isScrollEnabled = false
        tv.isEditable = true
        tv.keyboardType = .numberPad
        tv.tag = x
        tv.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        textViewArray.append(tv)
        }
        return textViewArray
    }
    func fetchingDefaultValues() {
        textViewArray[0].text = String(TIMER_MINUTES)
        textViewArray[1].text = String(TIMER_SECONDS)
        textViewArray[2].text = String(SET_NUM)
        textViewArray[3].text = String(BREAK_MINUTES)
        textViewArray[4].text = String(BREAK_SECONDS)
        breakQuoteTextView.text = DEFAULT_BREAK_QUOTE_TEXT
    }
//======================================================================
//======================================================================
                  /*  Keyboard Observation Functions */
            /* =============================================*/
    func observerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardShow(notification: NSNotification) {
        /*var keyboardHeight:CGFloat = 0
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardSize.height
            }*/
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: /*-(keyboardHeight)*/-100, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    @objc func keyboardHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
//======================================================================
//======================================================================
    
}
