//
//  ViewController.swift
//  AVFoundationRelaxationAudio
//
//  Created by admin on 28/12/2021.
//

import UIKit
import BAFluidView
import AVFoundation

class AudioViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var trackingUISlider: UISlider!
    
    let starsView = StarsAndRainUIViewController().starsView
    let rainView = StarsAndRainUIViewController().rainView
    var fluidView: BAFluidView!
    var startedFluidView: BAFluidView!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the background view and Fluid View
        createBAFluidView()
        view.addSubview(fluidView)
        view.addSubview(startedFluidView)
        view.addSubview(starsView)
        view.addSubview(rainView)
        view.sendSubviewToBack(fluidView)
        view.sendSubviewToBack(startedFluidView)
        view.sendSubviewToBack(starsView)
        view.sendSubviewToBack(rainView)
        starsView.backgroundColor = .clear
        rainView.backgroundColor = .clear
        rainView.isHidden = true
        view.sendSubviewToBack(backgroundImageView)
        
        //Create Gesture Recognizer
        addDoubleAndTripleGestureRecognizer()
        
        //Seeting Audio Player
        settingAudioData()
        
        //Setting Up The Tracking Slider
        guard let player = player else { return }
        trackingUISlider.maximumValue = Float(player.duration)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(sliderTrackingFunctionality), userInfo: nil, repeats: true)
    }
    
    func settingAudioData() {
        let urlString = Bundle.main.path(forResource: "Demi-Lovato-Sober-Official-Audio", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else { return }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
        }catch {
            print("Somthing Went Wrong")
        }
    }
    
    @IBAction func startPauseButton(_ sender: UIButton) {
        startPauseFunctionality()
    }
    
    func startPauseFunctionality() {
        if let player = player, player.isPlaying {
            player.pause()
            trackingLabel.text = "PAUSE"
            fluidView.isHidden = false
            startedFluidView.isHidden = true
        }else {
            guard let player = player else { return }
            player.play()
            trackingLabel.text = "PLAYING"
            fluidView.isHidden = true
            startedFluidView.isHidden = false
        }
    }
    
    @IBAction func detailsButton(_ sender: UIButton) {
        DetailsAlertUIView.instance.showAlert()
    }
    
    @IBAction func trackingSliderController(_ sender: UISlider) {
        if let player = player, player.isPlaying {
            player.stop()
            player.currentTime = TimeInterval(trackingUISlider.value)
            player.prepareToPlay()
            player.play()
        }else {
            guard let player = player else { return }
            player.currentTime = TimeInterval(trackingUISlider.value)
        }
    }
    
    @objc func starsViewLoad() {
        starsView.isHidden = false
        rainView.isHidden = true
    }
    
    @objc func rainViewLoad() {
        rainView.isHidden = false
        starsView.isHidden = true
    }
    
    func addDoubleAndTripleGestureRecognizer(){
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(starsViewLoad))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
        let tripleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(rainViewLoad))
        tripleTapRecognizer.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTapRecognizer)
    }
    
    func createBAFluidView() {
        fluidView = BAFluidView(frame: self.view.frame, startElevation: NSNumber(0.05))
        startedFluidView = BAFluidView(frame: self.view.frame, startElevation: NSNumber(0.05))
        fluidView.strokeColor = UIColor.white
        fluidView.fillColor = UIColor.cyan
        startedFluidView.strokeColor = UIColor.red
        startedFluidView.fillColor = UIColor.cyan
        startedFluidView.fillDuration = 30.0
        fluidView.fill(to: NSNumber(value: 0.05))
        startedFluidView.fill(to: NSNumber(value: 0.5))
        fluidView.startAnimation()
        startedFluidView.startAnimation()
        startedFluidView.isHidden = true
    }
    
    @objc func sliderTrackingFunctionality() {
        guard let player = player else { return }
        trackingUISlider.value = Float(player.currentTime)
    }
}

