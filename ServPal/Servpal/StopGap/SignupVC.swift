//
//  SignupVC.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/16/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import DLRadioButton
import SVProgressHUD

class SignupVC: UIViewController {

    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var serviceProviderButton: DLRadioButton!
    @IBOutlet weak var clientButton: DLRadioButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let kSignedUp = "signedUp"
    
    var selectedRole: String? {
        if serviceProviderButton?.isSelected ?? false{
            return "professional"
        }else if clientButton?.isSelected ?? false{
            return "member"
        }else{
            return nil
        }
    }
    
    var firstName: String? {
        if fullNameTF.text?.split(separator: " ").count ?? 0 >= 1{
            return fullNameTF.text?.split(separator: " ").map(String.init)[0]
        }else{
            return fullNameTF.text
        }
    }
    
    var lastName: String?{
        if fullNameTF.text?.split(separator: " ").count ?? 0 >= 2{
            return fullNameTF.text?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true).map(String.init)[1]
        }else{
            return fullNameTF.text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: kSignedUp){
            launchWebApp()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        signupButton.layer.cornerRadius = 5
        setSignupEnabled(canSignup())
    }

    func canSignup()->Bool{
        if !(fullNameTF.text?.isEmpty)! && !(emailTF.text?.isEmpty)! && !(passwordTF.text?.isEmpty)! && (serviceProviderButton.isSelected || clientButton.isSelected){
            return true
        }else{
            return false
        }
    }
    
    @IBAction func clientTapped(_ sender: DLRadioButton) {
        view.endEditing(true)
        if serviceProviderButton.isSelected{
            serviceProviderButton.isSelected = false
        }
        setSignupEnabled(canSignup())
    }
    
    @IBAction func serviceProviderTapped(_ sender: DLRadioButton) {
        view.endEditing(true)
        if clientButton.isSelected{
            clientButton.isSelected = false
        }
        setSignupEnabled(canSignup())
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        SVProgressHUD.setForegroundColor(UIColor.primary)
        SVProgressHUD.show()
        ServPalApiManager.signUp(selectedRole ?? "", emailTF.text ?? "", passwordTF.text ?? "", firstName ?? "", lastName ?? "") { [weak self] (user, error) in
            SVProgressHUD.dismiss()
            if error != nil{
                var errorMessage:String?
                if error.debugDescription.contains("409"){
                    errorMessage = "This user already exists"
                }
                let errorAlert = UIAlertController.init(title: "Error", message: errorMessage != nil ? errorMessage : error?.localizedDescription, preferredStyle: .alert)
                let closeAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                errorAlert.addAction(closeAction)
                self?.present(errorAlert, animated: true, completion: nil)
            }else{
                let successAlert = UIAlertController.init(title: "Success", message: "Your account has been created", preferredStyle: .alert)
                let continueAction = UIAlertAction.init(title: "Continue", style: .cancel, handler: {[weak self] (action) in
                    UserDefaults.standard.set(true, forKey: (self?.kSignedUp)!)
                    self?.launchWebApp()
                })
                successAlert.addAction(continueAction)
                self?.present(successAlert, animated: true, completion: nil)
            }
        }
    }
    
    func launchWebApp(){
        let webAppVC = storyboard?.instantiateViewController(withIdentifier: "WebAppVC") as! WebAppVC
        present(webAppVC, animated: true, completion: nil)
    }
    
    func setSignupEnabled(_ isEnabled:Bool){
        signupButton.backgroundColor = isEnabled ? UIColor.primary : UIColor.primaryLight
        signupButton.isEnabled = isEnabled
    }
    
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func termsAndConditionsTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.servpal.com/terms-of-service")!, options: [:], completionHandler: nil)
    }
    
    //MARK: - Keyboard Methods
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 15
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        launchWebApp()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - TextField Delegates
extension SignupVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setSignupEnabled(canSignup())
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setSignupEnabled(canSignup())
    }
}
