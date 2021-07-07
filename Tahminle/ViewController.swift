//
//  ViewController.swift
//  Tahminle
//
//  Created by Mac7 on 7.07.2021.
//  Copyright © 2021 hhgsun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isDev: Bool = true; //sunum esnasında true yapılabilir
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var round: Int = 5
    var score: Int = 0
    
    @IBOutlet weak var lblCan: UILabel!
    @IBOutlet weak var lblPuan: UILabel!
    @IBOutlet weak var lblYardim: UILabel!
    
    @IBOutlet weak var lblTargetShow: UILabel!
    
    @IBOutlet weak var inputSayi: UITextField!
    @IBOutlet weak var btnTahminle: UIButton!
    @IBOutlet weak var btnYenidenBasla: UIButton!
    
    override func viewDidLoad() {
        resetValues()
        super.viewDidLoad()
    }

    
    @IBAction func btnActionTahminle(_ sender: Any) {
        currentValue = Int(inputSayi.text ?? "-1") ?? -1;
        if(currentValue == -1) {
            showMessage(title: "Dikkat", message: "Lütfen Sayı Giriniz. (1-100)");
        } else {
            if(currentValue == targetValue) {
                score = score + 10;
                lblPuan.text = "\(score)"
                randomGenerate()
                lblYardim.text = "1-100 arası sayı tahmin et"
            } else {
                round = round - 1;
                lblCan.text = "\(round)"
                if(round < 1) {
                    showMessage(title: "Bitti", message: "Canınız tükendi, oyun bitti. \nSayı: \(targetValue)");
                    btnTahminle.isHidden = true
                    btnYenidenBasla.isHidden = false
                    lblYardim.text = "Maalesef yandın. dikkatli ol"
                } else {
                    if(currentValue > targetValue) {
                        if((currentValue - targetValue) < 10) {
                            lblYardim.text = "çok yaklaştın"
                        } else {
                            lblYardim.text = "tahminin çok büyük"
                        }
                    } else {
                        if((targetValue - currentValue) < 10) {
                            lblYardim.text = "çok yaklaştın"
                        } else {
                            lblYardim.text = "tahminin çok küçük"
                        }
                    }
                }
            }
            inputSayi.text = nil
        }
    }
    
    @IBAction func btnActionYenidenBasla(_ sender: Any) {
        resetValues();
    }
    
    func resetValues() {
        round = 5
        score = 0
        lblCan.text="\(round)"
        lblPuan.text = "\(score)"
        inputSayi.text = nil
        btnYenidenBasla.isHidden = true
        btnTahminle.isHidden = false
        lblYardim.text = "1-100 arası sayı tahmin edin"
        randomGenerate()
    }
    
    func randomGenerate() {
        targetValue = 1 + Int(arc4random_uniform(100))
        if(isDev) {
            lblTargetShow.text = "\(targetValue)"
        } else {
            lblTargetShow.isHidden = true;
        }
    }
    
    
    func showMessage(title:String, message: String){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

