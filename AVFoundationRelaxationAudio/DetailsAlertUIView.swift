//
//  DetailsAlertUIView.swift
//  AVFoundationRelaxationAudio
//
//  Created by admin on 28/12/2021.
//

import UIKit

class DetailsAlertUIView: UIView {
    
    static let instance = DetailsAlertUIView()

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let message = "Double Tap or Triple Tap on the Screen for More!\n\n(Triple Tap)\n*Rain Background View\n\n(Double Tap)\n*Back to Stars Background View\n\n\nEnjoy Listening to My Music\n\n@2022 Mohammad Jaha"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DetailsAlertView", owner: self, options: nil)
        settingView()
        messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func settingView() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.layer.cornerRadius = 20
    }
    
    @IBAction func gotItButton(_ sender: UIButton) {
        parentView.removeFromSuperview()
    }
    
    func showAlert() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow?.addSubview(parentView)
    }
}
