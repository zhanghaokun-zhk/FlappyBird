//
//  ViewController.swift
//  FlappyBirdDemo
//
//  Created by Admin on 2022/6/30.
//

import UIKit
let Screen_Size = UIScreen.main.bounds
class ViewController: UIViewController {
    var timerBG: Timer?
    var timerTube: Timer?
    var bird: UIImageView!
    var timerBird: Timer?
    var t: Float = 0.0
    var isUpward: Bool = false
    var tmp: Bool = true
    let diff: CGFloat = 220.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatBackgroundView()
        self.creatTube()
        self.creatBird()
        self.creatTimer()
        // Do any additional setup after loading the view.
    }
    func creatBackgroundView(){
        let imageCity = UIImage(named: "city.jpeg")
        let viewCity = UIImageView(image: imageCity)
        let viewCity2 = UIImageView(image: imageCity)
        viewCity.frame = CGRect(x: 0, y: 0, width: Screen_Size.width * 3, height: Screen_Size.height)
        viewCity2.frame = CGRect(x: Screen_Size.width * 3, y: 0, width: Screen_Size.width * 3 + 1, height: Screen_Size.height)
        self.view.addSubview(viewCity)
        self.view.addSubview(viewCity2)
        viewCity.tag = 101
        viewCity2.tag = 102
    }
    func creatTube(){
        let imageTubeUp = UIImage(named: "tube-up.png")
        let imageTubeDown = UIImage(named: "tube-down.png")
        //One
        let viewTubePairOneUp = UIImageView(frame: CGRect(x: 0, y: -Screen_Size.height + 0, width: 100, height: Screen_Size.height))
        let viewTubePairOneDown = UIImageView(frame: CGRect(x: 0, y: Screen_Size.height - 0, width: 100, height: Screen_Size.height))
        viewTubePairOneUp.image = imageTubeUp
        viewTubePairOneDown.image = imageTubeDown
        viewTubePairOneUp.tag = 201
        viewTubePairOneDown.tag = 202
        
        //Two
        let viewTubePairTwoUp = UIImageView(frame: CGRect(x: Screen_Size.width / 2, y: -Screen_Size.height + 0, width: 100, height: Screen_Size.height))
        let viewTubePairTwoDown = UIImageView(frame: CGRect(x: Screen_Size.width / 2, y: Screen_Size.height - 0, width: 100, height: Screen_Size.height))
        viewTubePairTwoUp.image = imageTubeUp
        viewTubePairTwoDown.image = imageTubeDown
        viewTubePairTwoUp.tag = 203
        viewTubePairTwoDown.tag = 204
        
        //Three
        let viewTubePairThreeUp = UIImageView(frame: CGRect(x: Screen_Size.width, y: -Screen_Size.height + 0, width: 100, height: Screen_Size.height))
        let viewTubePairThreeDown = UIImageView(frame: CGRect(x: Screen_Size.width, y: Screen_Size.height - 0, width: 100, height: Screen_Size.height))
        viewTubePairThreeUp.image = imageTubeUp
        viewTubePairThreeDown.image = imageTubeDown
        viewTubePairThreeUp.tag = 205
        viewTubePairThreeDown.tag = 206
        let viewGround = self.view.viewWithTag(102)!
        self.view.insertSubview(viewTubePairOneUp, aboveSubview: viewGround)
        self.view.insertSubview(viewTubePairOneDown, aboveSubview: viewGround)
        self.view.insertSubview(viewTubePairTwoUp, aboveSubview: viewGround)
        self.view.insertSubview(viewTubePairTwoDown, aboveSubview: viewGround)
        self.view.insertSubview(viewTubePairThreeUp, aboveSubview: viewGround)
        self.view.insertSubview(viewTubePairThreeDown, aboveSubview: viewGround)
        
    }
    func creatTimer(){
        timerBG = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.backgroundMove), userInfo: nil, repeats: true)
        timerTube = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.tubeMove), userInfo: nil, repeats: true)
        timerBird = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.birdMove), userInfo: nil, repeats: true)
    }
    @objc func backgroundMove(){
        let viewCity = self.view.viewWithTag(101)
        let viewCity2 = self.view.viewWithTag(102)
        if (viewCity?.frame.origin.x)! > -Screen_Size.width * 3{
            viewCity?.frame.origin.x -= 1
        }else {
            viewCity?.frame.origin.x = Screen_Size.width * 3
        }
        if (viewCity2?.frame.origin.x)! > -Screen_Size.width * 3{
            viewCity2?.frame.origin.x -= 1
        }else{
            viewCity2?.frame.origin.x = Screen_Size.width * 3
        }
    }
    @objc func tubeMove(){
        for i in stride(from: 201, to: 206, by: 2) {
            if self.view.viewWithTag(i)!.frame.origin.x > -Screen_Size.width / 2 {
                self.view.viewWithTag(i)?.frame.origin.x -= 2
                self.view.viewWithTag(i + 1)?.frame.origin.x -= 2
            }else {
                self.view.viewWithTag(i)?.frame.origin.x = Screen_Size.width
                self.view.viewWithTag(i + 1)?.frame.origin.x = Screen_Size.width
                self.getPosition(viewUp: self.view.viewWithTag(i) as! UIImageView, viewDown: self.view.viewWithTag(i + 1) as! UIImageView)
            }
        }
    }
    func getPosition(viewUp: UIImageView, viewDown: UIImageView){
        let height = arc4random() % 300 + 30
        viewUp.frame.origin.y = (CGFloat)(-Screen_Size.height) + (CGFloat)(height)
        viewDown.frame.origin.y = (CGFloat)(height) + diff
    }
    func creatBird(){
        let imageBird = UIImage(named: "bird.jpeg")
        bird = UIImageView(image: imageBird)
        bird.frame = CGRect(x: 50, y: 200, width: 50, height: 50)
        self.view.addSubview(bird)
    }
    @objc func birdMove(){
        if isUpward == false {
            if bird.frame.origin.y < Screen_Size.height - 140 {
                bird.frame.origin.y += (CGFloat)(9.8 * (t * t / 2) -  9.8 * (t - 0.02) * (t - 0.02) / 2) * 30
                t += 0.02
            }
        }else {
            if t < 0.2 {
                bird.frame.origin.y -= (CGFloat)((10.0 * t - 9.8 * t * t / 2) - (10.0 * (t - 0.02) - 9.8 * (t - 0.02) * (t - 0.02) / 2)) * 30
                t += 0.02
            }else {
                isUpward = false
            }
        }
        self.GameOver()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tmp == true {
            isUpward = true
            t = 0.0
        }else {
            tmp = true
            sleep(1)
            self.reload()
        }
    }
    func GameOver(){
        for i in 201 ... 206{
            if bird.frame.intersects(self.view.viewWithTag(i)!.frame) {
                timerBG!.fireDate = Date.distantFuture as Date
                timerTube!.fireDate = Date.distantFuture as Date
                timerBird!.fireDate = Date.distantFuture as Date
                tmp = false
                let GameOverBanner = UIImageView(frame: CGRect(x: 30, y: 100, width: Screen_Size.width - 60, height: Screen_Size.height / 2))
                GameOverBanner.image = UIImage(named: "over.jpeg")
                GameOverBanner.tag = 301
                self.view.addSubview(GameOverBanner)
            }
        }
    }
    func reload(){
        for i in stride(from: 201, to: 206, by: 2) {
            self.view.viewWithTag(i)?.frame = CGRect(x: Screen_Size.width * (CGFloat(i) - 201) / 4, y: -Screen_Size.height, width: 100, height: Screen_Size.height)
            self.view.viewWithTag(i + 1)?.frame = CGRect(x: Screen_Size.width * (CGFloat(i) - 201) / 4, y: -Screen_Size.height, width: 100, height: Screen_Size.height)
        }
        let GameOverBanner = self.view.viewWithTag(301)
        GameOverBanner?.removeFromSuperview()
        t = 0
        timerBG!.fireDate = Date.distantPast as Date
        timerTube!.fireDate = Date.distantPast as Date
        timerBird!.fireDate = Date.distantPast as Date
    }
}

