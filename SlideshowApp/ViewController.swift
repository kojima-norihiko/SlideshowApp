//
//  ViewController.swift
//  SlideshowApp
//
//  Created by kojima on 2020/01/06.
//  Copyright © 2020 kojima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prebutton: UIButton!
    @IBOutlet weak var forbutton: UIButton!
    @IBOutlet weak var gobutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var label: UILabel!
    /// 一定の間隔で処理を行うためのタイマー
    var timer: Timer!
    var image: UIImage!
    var imagekakudai: UIImage!
    
    @IBAction func gobutton(_ sender: Any) {
        gobutton.isHidden = true //ボタンを非表示
        backbutton.isHidden = false //ボタンを表示
        prebutton.isEnabled = false // ボタン無効
        forbutton.isEnabled = false // ボタン有効
        label.text = "停止"
        // タイマーを設定
               timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.updateTimer(_:)), userInfo: nil, repeats: true)

    }
    @IBAction func backbutton(_ sender: Any) {
        gobutton.isHidden = false //ボタンを表示
        backbutton.isHidden = true //ボタンを非表示
        prebutton.isEnabled = true // ボタン有効
        forbutton.isEnabled = true // ボタン有効
        label.text = "再生"
        self.timer.invalidate()
    }
    
    @IBAction func pre(_ sender: Any) {
    // 表示している画像の番号を1減らす
        dispImageNo -= 1

        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    @IBAction func foward(_ sender: Any) {
    // 表示している画像の番号を1増やす
    dispImageNo += 1

    // 表示している画像の番号を元に画像を表示する
    displayImage()
    }
    
    @IBAction func tapview(_ sender: Any) {
    print("タップされました")
        self.performSegue(withIdentifier: "tonext", sender: nil)
}
    /// 表示している画像の番号
    var dispImageNo = 0

    /// 表示している画像の番号を元に画像を表示する
    func displayImage() {

        // 画像の名前の配列
        let imageNameArray = [
            "1482907330269.jpg",
            "Du5XMxNVAAEnkpS.jpg",
            "EBN4A7dVAAEO4vS.png",
            "images.jpg",
        ]
        
        // 範囲より下を指している場合、最後の画像を表示
        if dispImageNo < 0 {
            dispImageNo = 3
        }

        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > 3 {
            dispImageNo = 0
        }

        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[dispImageNo]
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        // 画像を読み込み
        image = UIImage(named: name)

        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    /// NSTimerによって、一定の間隔で呼び出される関数
    @objc func updateTimer(_ timer: Timer) {

        // 関数が呼ばれていることを確認
        print("onTimer")

        // 表示している画像の番号を1増やす
        dispImageNo += 1

        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image = UIImage(named: "1482907330269.jpg")
        imageView.image = image
        backbutton.isHidden = true //ボタンを非表示
        label.text = "再生"
  }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // segueから遷移先のResultViewControllerを取得する
    let kakudaiViewController:kakudaiViewController = segue.destination as! kakudaiViewController
    // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        kakudaiViewController.image = self.image
        imagekakudai = self.image
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        image = imagekakudai
        imageView.image = image
    }
}

