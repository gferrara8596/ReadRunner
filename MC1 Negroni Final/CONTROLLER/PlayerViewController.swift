//
//  PlayerViewController.swift
//  MC1 Negroni Final
//
//  Created by Giuseppe Ferrara on 22/11/2019.
//  Copyright © 2019 Sfugliatell. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class PlayerViewController: UIViewController {
    
    var pedometer = CMPedometer()
    var startDate: Date?
    var sessionTimer: Timer?
    var activityManager = CMMotionActivityManager()
    var dataTimer = Timer()
    var labelTimer = Timer()
    
    
    // MARK: INTERFACE BUILDER OUTLETS
    @IBOutlet weak var bookCoverBackgroundImageView: UIImageView!
    var bookCoverImage: UIImage?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var remainingSteps: UILabel!
    @IBOutlet weak var stepsMade: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var timeSession: UILabel!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var avgPace: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var skip30sButton: UIButton!
    @IBOutlet weak var back30sButton: UIButton!
    
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var avgPaceInfoLabel: UILabel!
    @IBOutlet weak var distanceInfoLabel: UILabel!
    
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var sessionStatsView: UIView!
    @IBOutlet weak var pullDownBarView: UIView!
    @IBOutlet weak var runModeView: UIView!
    @IBOutlet weak var walkModeView: UIView!
    @IBOutlet weak var runModeImage: UIImageView!
    @IBOutlet weak var walkModeImage: UIImageView!
    
    
    var audioBook: AudioBook!
    var player: AVAudioPlayer?
    var chapterIndex: Int!
    var runningModeOn = false
    var isPlaying = false
    var numberOfStepsMade: Int?
    var averagePace: Double?
    var userDistance: Double?
    var url: URL?
    var firstView = true
    var ssTimer: Timer?
    var mmTimer: Timer?
    var hhTimer: Timer?
    var ss: Int?
    var mm: Int?
    var hh: Int?
    var maxTimeReached: Double = 0.0
    var sliderShouldBeUpdated = true
    var fullMotionControlEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDate = Date()
        //load all the view
        initPlayer()
        dataTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.pedometer.queryPedometerData(from: self.startDate!, to: Date(), withHandler: { pedometerData, error in
                if let error = error { print(error); return }
                // do something with the data
                self.numberOfStepsMade = pedometerData?.numberOfSteps.intValue
                self.averagePace = pedometerData?.currentPace?.doubleValue
                self.userDistance = pedometerData?.distance?.doubleValue
//                print("steps updated!")
            })
        })
        
        labelTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.updateLabels()
        })
        
        roundCorners(of: pullDownBarView, by: 3)
        
        scheduleSessionTimers()
        
        loadFirstView()
        changeFromSecondViewToFirst()
        startActivityManagerUpdates()
        
        // Set up font for labels on start
        titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 32)
        authorLabel.font = UIFont(name: "SFProDisplay-Medium", size: 23)
        chapterLabel.font = UIFont(name: "SFCompactDisplay-Light", size: 23)
        remainingSteps.font = UIFont(name: "SFProText-Regular", size: 14)
        stepsLabel.font = UIFont(name: "SFProDisplay-Light", size: 24)
        
        // Set up font for labels with session stats
        timeInfoLabel.font = UIFont(name: "SFProDisplay-Light", size: 15)
        timeSession.font = UIFont(name: "SFProDisplay-Bold", size: 69)
        avgPaceInfoLabel.font = UIFont(name: "SFProDisplay-Light", size: 15)
        avgPace.font = UIFont(name: "SFProDisplay-Bold", size: 69)
        distanceInfoLabel.font = UIFont(name: "SFProDisplay-Light", size: 15)
        distance.font = UIFont(name: "SFProDisplay-Bold", size: 69)

//        putPlayerInBackground()
        loadControls()
        
        view.addSubview(tapView)
        bookCoverBackgroundImageView.image = bookCoverImage
        
        runModeView.roundCorners(topLeft: 11, topRight: 0, bottomLeft: 50, bottomRight: 0)
        walkModeView.roundCorners(topLeft: 0, topRight: 50, bottomLeft: 0, bottomRight: 11)
        
    }
    
    func loadControls(){
        if fullMotionControlEnabled {
            infoLabel.isHidden = false
            playPauseButton.isHidden = true
            back30sButton.isHidden = true
            skip30sButton.isHidden = true
        } else {
            infoLabel.isHidden = true
            playPauseButton.isHidden = false
            back30sButton.isHidden = false
            skip30sButton.isHidden = false
        }
    }
    
    
    func initPlayer(){
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.prepareToPlay()
        player?.enableRate = true
        // Access the shared, singleton audio session instance
        let session = AVAudioSession.sharedInstance()
        do {
            // Configure the audio session for movie playback
            try session.setCategory(AVAudioSession.Category.playback,
                                    mode: AVAudioSession.Mode.moviePlayback,
                                    options: [])
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error as NSError {
            print("Failed to set the audio session category and mode: \(error.localizedDescription)")
        }
        
        progressBar.isContinuous = true
        progressBar.minimumValue = 0
        progressBar.maximumValue = Float(player?.duration ?? 0)
        progressBar.isUserInteractionEnabled = false
        
    }
    
    func updateLabels(){
        stepsMade.text = "\(numberOfStepsMade ?? 0)"
        avgPace.text = "\(averagePace ?? 0)"
        let distanceInKm = (userDistance ?? 0)/1000
        distance.text = "\(distanceInKm) km"
        distance.text = String(format: "%.2", distanceInKm)
        maxTimeReached = player?.currentTime ?? 0
        
        if sliderShouldBeUpdated {
            progressBar.setValue(Float(player?.currentTime ?? 0), animated: true)
        }
        
        let timeString = "\(hh ?? 0):\(mm ?? 0):\(ss ?? 0)"
        timeSession.text = timeString
        let stepsDifference: Int = Int(((player?.duration ?? 0) * 2)) - (numberOfStepsMade ?? 0)
        remainingSteps.text = "\(stepsDifference) steps remaining until Chapter \(chapterIndex + 2)"
//        print("labels updated")
    }
    
    func roundCorners(of view: UIView, by radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }

    
    func scheduleSessionTimers(){
        ssTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.ss = (self.ss ?? 0) + 1
            if self.ss == 60 {
                self.ss = 0
            }
        })
        mmTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: {_ in
            self.mm = (self.mm ?? 0) + 1
            if self.mm == 60 {
                self.mm = 0
            }
        })
        hhTimer  = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true, block: {_ in
            self.hh = (self.hh ?? 0) + 1
            if self.hh == 24 {
                self.hh = 0
            }
        })
    }
    
    
//    func putPlayerInBackground(){
//        do{
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//            print("player in background")
//        } catch{
//            print("Failure. Error: \(error)")
//        }
//    }
    
    //if is playing will continue to play in another view
    override func viewWillDisappear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            if self.player?.isPlaying ?? false { // for play in other views
//                self.player?.play()
//            }
//        }
        
        player?.stop() // stop the player when the view is leaved
        activityManager.stopActivityUpdates()
        dataTimer.invalidate()
        labelTimer.invalidate()
        ssTimer?.invalidate()
        mmTimer?.invalidate()
        hhTimer?.invalidate()
        print("player stopped, timers invalidated and view disappeared")
    }
    
    func loadFirstView() {
        titleLabel.text = audioBook.title
        chapterLabel.text = "Chapter \((chapterIndex ?? 0) + 1)"
        playPauseButton.titleLabel?.text = "Play"
        playPauseButton.isHidden = true
        authorLabel.text = audioBook.author
        
    }
    
    
    
    func changeFromFirstToSecondView() {
        titleLabel.isHidden = true
        authorLabel.isHidden = true
        chapterLabel.isHidden = true
        stepsMade.isHidden = true
        remainingSteps.isHidden = true
        stepsLabel.isHidden = true
        sessionStatsView.isHidden = false
//        timeSession.isHidden = false
//        distance.isHidden = false
//        avgPace.isHidden = false
        pageController.currentPage = 1
        firstView = false
    }
    
    func changeFromSecondViewToFirst(){
        titleLabel.isHidden = false
        authorLabel.isHidden = false
        chapterLabel.isHidden = false
        stepsMade.isHidden = false
        remainingSteps.isHidden = false
        stepsLabel.isHidden = false
        sessionStatsView.isHidden = true
//        timeSession.isHidden = true
//        distance.isHidden = true
//        avgPace.isHidden = true
        pageController.currentPage = 0
        firstView = true
    }
    
    
    func startActivityManagerUpdates() {
        
        print("activityManager Update called")
        
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            
            [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else { return }
            
            if self?.player != nil {
                DispatchQueue.main.async {
                    if activity.walking {
                        print("-- Walking: Ok")
                        if !(self?.runningModeOn ?? false) {
                            self?.player?.rate = 1.0
                            self?.player?.play()
                            self?.playPauseButton.titleLabel?.text = "Pause"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Pause Button"), for: .normal)
                            self?.infoLabel.text = "Good job, continue like this!"
                        } else if self?.runningModeOn ?? false {
                            self?.player?.rate = 0.8
                            self?.player?.play()
                            self?.playPauseButton.titleLabel?.text = "Pause"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Pause Button"), for: .normal)
                            self?.isPlaying = true
                            self?.infoLabel.text = "Run in order to listen properly"
                        }
                    } else if activity.stationary {
                        print("-- Stationary: Ok")
                        self?.player?.pause()
                        self?.playPauseButton.titleLabel?.text = "Play"
                        if !(self?.runningModeOn ?? false) {
                            self?.infoLabel.text = "Start Walking to listen the Audiobook"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Continue Walking Button"), for: .normal)
                        } else {
                            self?.infoLabel.text = "Start Running to listen the Audiobook"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Continue Running Button"), for: .normal)
                        }
                    } else if activity.running {
                        print("-- Running: Ok")
                        if self?.runningModeOn ?? false {
                            self?.player?.rate = 1.0
                            self?.player?.play()
                            self?.playPauseButton.titleLabel?.text = "Pause"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Pause Button"), for: .normal)
                            self?.infoLabel.text = "Good job, continue like this!"
                        } else if !(self?.runningModeOn ?? false) {
                            self?.player?.rate = 1.25
                            self?.player?.play()
                            self?.playPauseButton.titleLabel?.text = "Pause"
                            self?.playPauseButton.setImage(UIImage(imageLiteralResourceName: "Pause Button"), for: .normal)
                            self?.isPlaying = true
                            self?.infoLabel.text = "Walk in order to listen properly"
                        }
                    } else if activity.automotive {
                        print("-- Automotive: Ok")
                        self?.player?.pause()
                        self?.playPauseButton.titleLabel?.text = "Play"
                        let alert = UIAlertController(title: "Please Park the Car!", message: "You need to walk or run if you want listen an audiobook", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "I'll Go", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Please select a book first", message: "you need to select a book and a chapter to listen", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
    }
    
    // MARK: INTERFACE BUILDER ACTIONS
    
    @IBAction func runWalkingMode(_ sender: UISwitch) {
        self.runningModeOn = sender.isOn
        print("running mode on: \(runningModeOn)")
    }
    
    @IBAction func modeCustomToggle(_ sender: Any) {
        runningModeOn.toggle()
        if runningModeOn {
            runModeView.backgroundColor = #colorLiteral(red: 1, green: 0.8170133233, blue: 0.225202769, alpha: 1)
            runModeImage.image = UIImage(named: "Run Mode Yellow")
            walkModeView.backgroundColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
            walkModeImage.image = UIImage(named: "Walk Mode Grey")
            print("Run mode activated")
//            runningModeOn = false
        } else {
            runModeView.backgroundColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
            runModeImage.image = UIImage(named: "Run Mode Grey")
            walkModeView.backgroundColor = #colorLiteral(red: 1, green: 0.8170133233, blue: 0.225202769, alpha: 1)
            walkModeImage.image = UIImage(named: "Walk Mode Yellow")
//            runningModeOn = true
            print("Walk mode activated")
        }
        
    }
    
    @IBAction func back30s(_ sender: UIButton) {
        player?.pause()
        player?.play(atTime: (player?.currentTime ?? 0.0) - 30.0)
    }
    
    
    @IBAction func playPauseButton(_ sender: UIButton) {
        if isPlaying {
            sender.titleLabel?.text = "Play"
            isPlaying = false
            playPauseButton.setImage(UIImage(imageLiteralResourceName: "Play Button"), for: .normal)
            player?.pause()
        } else {
            sender.titleLabel?.text = "Pause"
            isPlaying = true
            playPauseButton.setImage(UIImage(imageLiteralResourceName: "Pause Button"), for: .normal)
            player?.play()
        }
    }
    
    
    @IBAction func forw30s(_ sender: UIButton) {
        player?.pause()
        player?.play(atTime: (player?.currentTime ?? 0.0) + 30.0)
    }
    


    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        print("view tapped")
        if firstView {
            changeFromFirstToSecondView()
        } else {
            changeFromSecondViewToFirst()
        }
    }
    
    
    
}


//MARK: BUTTON INTERFACE EXTENSIONS

extension UIView{
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}

