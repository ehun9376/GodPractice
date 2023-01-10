//
//  ViewController.swift
//  GodPractice
//
//  Created by 陳逸煌 on 2023/1/9.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    var audioplayer:AVAudioPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()
        audioplayer.play()
        do{
            self.audioplayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "holdBreath", withExtension: "mp3")!)
        }
        catch{
            print("音樂載入錯誤\(error)")
        }
        // Do any additional setup after loading the view.
    }
    
    


}

