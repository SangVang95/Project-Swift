//
//  SignUpController.swift
//  FashionApp
//
//  Created by Apple on 4/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNumberPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbErrName: UILabel!
    @IBOutlet weak var lbErrNumberPhone: UILabel!
    @IBOutlet weak var lbErrPassword: UILabel!
    @IBOutlet weak var lbErrEmail: UILabel!
    @IBOutlet weak var btnConfirmSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customElement()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = Resource.Text.textHeaderSignup
             navigationController?.navigationBar.barTintColor = Resource.Color.colorHeader
             navigationItem.backBarButtonItem?.title = "Back"
    }
    //MARK: Custom Element
    private func customElement() {
        //Text field
        Resource.StyleElement.styleTextField(textfield: tfName, placeHolder: "Patrice")
        Resource.StyleElement.styleTextField(textfield: tfNumberPhone, placeHolder: "0396000111")
        Resource.StyleElement.styleTextField(textfield: tfEmail, placeHolder: "email@gmail.com")
        Resource.StyleElement.styleTextField(textfield: tfPassword, placeHolder: "Aa1234")
        //Button
        Resource.StyleElement.styleBtn(btn: btnConfirmSignup, title: "Confirm")
    }
    //MARK: Handle create user
    @IBAction func onTapBtnConfirmsignup(_ sender: Any) {
        let name = tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let numberPhone = tfNumberPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if name == "" {
            Validate.lbShowError(msg: "*Please fill in this field", lable: lbErrName)
        }
        if numberPhone == "" {
            Validate.lbShowError(msg: "*Please fill in this field", lable: lbErrNumberPhone)
        }
        if email == "" {
            Validate.lbShowError(msg: "*Please fill in this field", lable: lbErrEmail)
        }
        if password == "" {
            Validate.lbShowError(msg: "*Please fill in this field", lable: lbErrPassword)
        }
        //Checking ensure valid password
        let checkingPassword = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Validate.isValidatePassword(password: checkingPassword!) == false {
            return Validate.lbShowError(msg: "Password is invalid", lable: lbErrPassword)
        }
        //Create user
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                Dialog.showDialogSignUp(title: "SignUp", msg: "Create user failed", titleAction: "OK", target: self)
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name" : name as Any, "numberphone" : numberPhone as Any, "uid" : result?.user.uid as Any]) { (error) in
                    if error != nil {
                        Dialog.showDialogSignUp(title: "SignUp", msg: "Error saving data", titleAction: "OK", target: self)
                    }
                }
                // Dang ki thanh cong
                Dialog.showDialogSignUp(title: "Sign Up", msg: "You created success!", titleAction: "Ok", target: self)
                self.lbErrPassword.text = ""
                self.lbErrEmail.text = ""
                self.lbErrName.text = ""
                self.lbErrNumberPhone.text = ""
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}