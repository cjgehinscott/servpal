//
//  ViewController.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var loading: Bool = false {
        didSet {
            loading ? DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator.startAnimating()
                }  : DispatchQueue.main.async { [weak self] in
                    self?.loadingIndicator.stopAnimating()
            }
        }
    }

    let manager = UserManager()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        var loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.hidesWhenStopped = true

        self.view.addSubview(loadingIndicator)

        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.size.equalTo(50)
        }
        return loadingIndicator
    }()


    lazy var container: UIStackView = {
        let field = UIStackView()
        self.view.addSubview(field)
        field.axis = .vertical
        field.distribution = .fillEqually
        field.spacing = 15
        return field
    }()

    lazy var emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = UIKeyboardType.emailAddress
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.placeholder = "Email"
        if let user = User.allObjects(in: RealmManager.shared.realm).firstObject() as? User{
            field.text = user.email
        }
        return field
    }()

    lazy var passwordField: UITextField = {
        let field = UITextField()
        self.view.addSubview(field)
        field.placeholder = "Password"
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        return field
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accent
        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accent
        button.setTitle("Go Back", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.barTintColor = .primary
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Login"
        self.view.backgroundColor = .white

        container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(20)
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(30)
        }

        self.container.addArrangedSubview(emailField)
        self.container.addArrangedSubview(passwordField)
        self.container.addArrangedSubview(loginButton)
        self.container.addArrangedSubview(backButton)
    }

    @objc
    func loginTapped() {
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(message: "Please fill out all fields.")
            return
        }

        loading = true

        manager.login(email: email, password: password) { [weak self] result,error in

            guard let `self` = self else {
                return
            }

            self.loading = false
            if result != nil{
                DispatchQueue.main.async {
                    //self.present(UINavigationController(rootViewController: MainViewController()), animated: true)
                }
            }else{
                self.showAlert(message: error?.error ?? "Unknown Error")
            }
        }
    }
    
    @objc
    func goBack(){
        self.present((UINavigationController(rootViewController: WelcomeViewController())), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //For error messages
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {[weak self] in
            self?.present(alert, animated: true)
        }
        
    }
}

