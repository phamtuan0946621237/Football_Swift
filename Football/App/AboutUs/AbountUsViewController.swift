//
//  AbountUsViewController.swift
//  Football
//
//  Created by admin on 2/5/21.
//

import UIKit

class AbountUsViewController: UIViewController {

    @IBOutlet weak var LayoutView: UIView!
    
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var inputContentView: UITextField!
    @IBOutlet weak var inputEmailView: UITextField!
    @IBOutlet weak var inputNameView: UITextField!
    var name : String?
    var email : String?
    var content : String?
    
    
//        = UIAlertView(title: "Thành công", message: "Gửi Contact Thành công",
//                         delegate: self, cancelButtonTitle: "OK")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    @IBAction func inputName(_ sender: Any) {
        print("inputNameView",inputNameView.text)
    }
    @IBAction func inputEmail(_ sender: Any) {
        print("inputEmailView",inputEmailView.text)
    }
    @IBAction func inputContent(_ sender: Any) {
        print("inputContentView",inputContentView.text)
    }

    @IBAction func onClickSend(_ sender: Any) {
        print("inputNameView",inputNameView.text)
        print("inputEmailView",inputEmailView.text)
        print("inputContentView",inputContentView.text)
        if inputNameView.text == "" {
        emptyTitle.textColor = .red
        emptyTitle.text = "Name không được để trống"
        }
        if inputNameView.text != "" && inputEmailView.text == "" {
        emptyTitle.textColor = .red
        emptyTitle.text = "Email không được để trống"
        }
        if inputNameView.text != "" && inputEmailView.text != "" &&  inputContentView.text == "" {
        emptyTitle.textColor = .red
        emptyTitle.text = "Content không được để trống"
        }
        if inputNameView.text != "" && inputEmailView.text != "" &&  inputContentView.text != "" {
            self.getPostSend()
        }
        
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AbountUsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func getPostSend() {
        let service = Connect()
        service.fetchPost()
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                print("hellooooooo : ",data)
                if data!["message"] as? String == "success" {
                    let alert = UIAlertController(title: "Thành công", message: "Gửi Contact thành công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self!.inputNameView.text = ""
                        self!.inputEmailView.text = ""
                        self!.inputContentView.text = ""
                        
                    }))
                    self!.present(alert, animated: true)
                    
                }
            }
        }
    }
}
