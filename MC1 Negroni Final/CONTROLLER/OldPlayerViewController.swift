////
////  PlayerViewController.swift
////  MC1 Negroni Final
////
////  Created by Alessio Vetrano on 21/11/2019.
////  Copyright © 2019 Sfugliatell. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//import CoreMotion
//import Dispatch
//
//
//class OldPlayerViewController: UIViewController {
//    
//    var path: String?
//    // var url: URL?
//    var valueSetted = false
//    var saveTimer: Timer!
//    
//    
//    // OLIVIER
//    var audioBookPlayer: AudioBookPlayer?
//    
//    
//    init?(audioBookPlayer: AudioBookPlayer) {
//        
//        guard let audioBookPlayerUnwrapped = audioBookPlayer as? AudioBookPlayer else {
//            return
//        }
//        
//        self.audioBookPlayer = audioBookPlayerUnwrapped
//        // audioBookPlayerUnwrapped.path
//        
//    } // init?()
//    
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    // END OLIVIER
//    
//    //    do {
//    //    let audioBookPlayer = try AudioBookPlayer(illustration: self.audioBookIllustration , title: String? , path: String? , url: URL? , audioTrack: AVAudioPlayer?)
//    //    } catch  {
//    //
//    //    }
//    
//    
//    @IBOutlet weak var errorLabel: UILabel!
//    
//    //    struct AudioBook {
//    //
//    //        var illustration: UIImage!
//    //        var title: String!
//    //        // var path: String!
//    //        var path: String? // OLIVIER
//    //        // var url: URL!
//    //        var url: URL? // OLIVIER
//    //        // var audioTrack: AVAudioPlayer!
//    //        var audioTrack: AVAudioPlayer?
//    //
//    //        if let unwrappedPath = path {
//    //            url = URL.init(fileReferenceLiteralResourceName: unwrappedPath)
//    //            self.errorLabel.isHidden = true
//    //        } else {
//    //            self.errorLabel.text = "Select Book First"
//    //            self.errorLabel.isHidden = false
//    //        } // END if let unwrappedPath {}
//    //
//    //    } // END struct AudioBook
//    
//    var updateProgressbar: Float = 0
//    // var player: AVAudioPlayer!
//    var player: AVAudioPlayer? // OLIVIER
//    var pedometer = CMPedometer()
//    var startData: Date!
//    var activityManager = CMMotionActivityManager()
//    var timer = Timer()
//    
//    
//    // MARK: INTERFACE BUILDER OUTLETS
//    
//    @IBOutlet weak var LabelRun: UILabel!
//    @IBOutlet weak var progressSlider: UISlider!
//    @IBOutlet weak var TimeCurrent: UILabel!
//    @IBOutlet weak var StepTimeLabel: UILabel!
//    @IBOutlet weak var TimeRemaining: UILabel!
//    @IBOutlet weak var TimeRemainingStep: UILabel!
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        loadData()
//        
//        timer = Timer.scheduledTimer(
//            withTimeInterval: 15.0 ,
//            repeats: true ,
//            block: { _ in
//                self.saveData()
//        })
//        
//        progressSlider.setValue(0.0 , animated : true)
//        do{
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//        } catch{
//            print("Failure. Error: \(error)")
//        }
//        self.setUpPlayer()
//        
//        //        dichiarazione tempi
//        
//        //        let currentTime1 = Int((player.duration-player.currentTime))
//        //        let minutes2 = currentTime1/60
//        //        let seconds2 = currentTime1 - minutes2*60
//        //        TimeCurrent.text = NSString(format: "%02d:%02d", minutes2, seconds2) as String
//        //        TimeCurrent.font = TimeCurrent.font.withSize(10)
//        //
//        //        let duration = Int((player.duration-(player.currentTime)))
//        //        let minutes = currentTime1/60
//        //        let seconds = currentTime1 - minutes2*60
//        //        TimeRemaining.text = NSString(format: "%02d:%02d", minutes, seconds) as String
//        //        TimeRemaining.font = TimeRemaining.font.withSize(10)
//        //
//        
//        
//        startData = Date()
//        
//        startActivityManagerUpdates()
//        
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            if audioBookPlayer.isPlaying {
//                audioBookPlayer.play()
//            }
//        }
//    }
//    
//    
//    func loadData(){
//        let urlState = UserDefaults.standard
//        let timeState = UserDefaults.standard
//        if let urlLoaded = urlState.url(forKey: "url") {
//            url = urlLoaded
//        }
//        
//        let timeLoaded = timeState.double(forKey: "time")
//        if timeLoaded != 0.0 {
//            player.play(atTime: timeLoaded)
//            player.pause()
//        }
//    }
//    
//    // TO save the data when you close the app .
//    func saveData(){
//        let urlState = UserDefaults.standard
//        urlState.set(url, forKey: "url")
//        let timeState = UserDefaults.standard
//        timeState.set(player.currentTime, forKey: "time")
//    }
//    
//    //    func startActivityManagerUpdates() {
//    //        print("activityManager Update called")
//    //        activityManager.startActivityUpdates(to: OperationQueue.main) {
//    //            [weak self] (activity: CMMotionActivity?) in
//    //            guard let activity = activity else { return }
//    //            if self!.valueSetted {
//    //                DispatchQueue.main.async {
//    //                    if activity.walking {
//    //                        print("-- Walking: Ok")
//    //
//    //
//    //                        self?.player.prepareToPlay()
//    //                        self?.player.enableRate = true
//    //                        self?.player.rate = 1.0
//    //                        self?.player.play()
//    //                        self?.updatetimer1()
//    //                        self?.updateTimer2()
//    //                        self?.updatetimer3()
//    //                        self?.updateTimer4()
//    //                        self?.updateProgress()
//    //                        self?.LabelRun.isHidden = true
//    //
//    //
//    //
//    //                    } else if activity.stationary {
//    //                        print("-- Stationary")
//    //                        self?.player.pause()
//    //                        self?.LabelRun.isHidden = false
//    //
//    //                        self?.LabelRun.text = "Run to start listening"
//    //                        self?.LabelRun.textColor = UIColor.yellow
//    //                    } else if activity.running {
//    //
//    //                        self?.LabelRun.isHidden = true
//    //                        self?.player.play()
//    //                        self?.updatetimer1()
//    //                        self?.updateTimer2()
//    //                        self?.updatetimer3()
//    //                        self?.updateTimer4()
//    //
//    //                        self?.updateProgress()
//    //
//    //
//    //
//    //                    }
//    //                }
//    //
//    //
//    //            } else {
//    //                let alert = UIAlertController(title: "Please select a book first", message: "you need to select a book and a chapter to listen", preferredStyle: .alert)
//    //
//    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//    //
//    //                self?.present(alert, animated: true)
//    //            }
//    //        }
//    //
//    //    }
//    
//    func setUpPlayer() {
//        
//        // OLIVIER :
//        
//        //        if let unwrappedPath = path {
//        //            url = URL.init(fileReferenceLiteralResourceName: unwrappedPath)
//        //            self.errorLabel.isHidden = true
//        //        } else {
//        //            self.errorLabel.text = "Select Book First"
//        //            self.errorLabel.isHidden = false
//        //        } // END if let unwrappedPath {}
//        
//        //        if let unwrappedURL = url {
//        //            do {
//        //                let player = try AVAudioPlayer(contentsOf: unwrappedURL)
//        //            } catch {
//        //                print(error)
//        //            } // END do {} catch {}
//        //        } // END if let unwrappedURL {}
//        //
//        //        // END OLIVIER
//        
//        
//        //        if path != nil {
//        //            url = URL.init(fileReferenceLiteralResourceName: path!)
//        //            self.errorLabel.isHidden = true
//        //        } else {
//        //            self.errorLabel.text = "Select Book First"
//        //            self.errorLabel.isHidden = false
//        //        }
//        
//        //        if url != nil {
//        //            do {
//        //                player = try AVAudioPlayer(contentsOf: url!)
//        //
//        //            } catch {
//        //                print(error)
//        //            }
//        //        }
//        
//    } // func setUpPlayer() {}
//    
//    
//    
//    func updateProgress() {
//        
//        let percDuration = (1/audioBookPlayer.duration) * player.currentTime
//        
//        progressSlider.setValue(Float(percDuration), animated: true)
//        
//    }
//    
//    
//    
//    func updatetimer1() {
//        
//        let currentTime1 = Int((audioBookPlayer.currentTime) * 1.40 )
//        let minutes2 = currentTime1/60
//        let seconds2 = currentTime1 - minutes2*60
//        StepTimeLabel.text = String(currentTime1)
//        StepTimeLabel.font = StepTimeLabel.font.withSize(100)
//        StepTimeLabel.textColor = UIColor.yellow
//        
//    }
//    
//    
//    func updateTimer2() {
//        
//        let duration = Int((player.duration-(audioBookPlayer.currentTime))*1.40)
//        let minutes = duration/60
//        let seconds = duration - minutes*60
//        TimeRemainingStep.text = String(duration)
//        TimeRemainingStep.font = TimeRemainingStep.font.withSize(40)
//        
//    }
//    
//    
//    func updatetimer3() {
//        
//        let currentTime2 = Int((audioBookPlayer.currentTime))
//        let minutes2 = currentTime2/60
//        let seconds2 = currentTime2 - minutes2*60
//        TimeCurrent.text = String(currentTime2)
//        TimeCurrent.text = NSString(format: "%02d:%02d", minutes2, seconds2) as String
//        TimeCurrent.font = TimeCurrent.font.withSize(10)
//        
//    }
//    
//    
//    func updateTimer4() {
//        
//        let duration2 = Int((player.duration-(audioBookPlayer.currentTime)))
//        let minutes = duration2/60
//        let seconds = duration2 - minutes*60
//        TimeRemaining.text = NSString(format: "%02d:%02d", minutes, seconds) as String
//        TimeRemaining.text = String(duration2)
//        TimeRemaining.font = TimeRemaining.font.withSize(10)
//        
//    }
//    
//    
//    //    func startActivityManagerUpdates(_ sender: UISwitch) {
//    //
//    //        startActivityManagerUpdates()
//    //
//    //    }
//    
//    
//}
