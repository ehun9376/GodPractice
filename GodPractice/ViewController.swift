//
//  ViewController.swift
//  GodPractice
//
//  Created by 陳逸煌 on 2023/1/9.
//

import UIKit

import AVFoundation

class ViewController: BaseViewController {
        
    var audioplayer: AVAudioPlayer?

    @IBOutlet weak var soundButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setSettingButton()
        self.setSoundButton(defaultSet: true, type: ProductID.woodFish)
        self.setAVFoundation(type: ProductID.woodFish)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let current = UserInfoCenter.shared.loadValue(.current) as? String {
            
            let types: [ProductID] = [.woodFish,.gong,.inSin,.ring,.drum]
            
            if let type = types.first(where: {$0.text == current}) {
                self.setSoundButton(type: type)
                self.setAVFoundation(type: type)
            }
            
        }
    }
    
    func setSettingButton() {
        self.settingButton.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
    }
    
    @objc func settingButtonAction() {
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setSoundButton(defaultSet: Bool = false, type: ProductID) {
        
        
        
        if defaultSet {
            self.soundButton.configuration = nil
            self.soundButton.layer.cornerRadius = self.settingButton.frame.height / 2
            self.soundButton.clipsToBounds = true
            self.soundButton.setTitle(nil, for: .normal)
            self.soundButton.addTarget(self, action: #selector(soundButtonAction), for: .touchUpInside)
        }
        
        if let image = UIImage(named: type.soundName) {
            self.soundButton.imageView?.contentMode = .scaleToFill
            self.soundButton.setImage(image, for: .normal)
        }
        
        
        
    }
    
    @objc func soundButtonAction() {
        
        if let audioplayer = self.audioplayer {
            if audioplayer.isPlaying {
                audioplayer.currentTime = 0
                audioplayer.play()
            } else {
                audioplayer.play()  
            }
            
        }
        
       
    }
    
    func setAVFoundation(type: ProductID) {
        if let url = Bundle.main.url(forResource: type.soundName,
                                     withExtension: "mp3") {
            self.audioplayer = try? AVAudioPlayer(contentsOf: url)
        }
        
       
    }


}

