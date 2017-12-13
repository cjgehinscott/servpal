//
//  ViewController.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {

    let padding: CGFloat = 25

    let manager = UserManager()

    var loading: Bool = false {
        didSet {
            loading ? DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator.startAnimating()
                } : DispatchQueue.main.async { [weak self] in
                    self?.loadingIndicator.stopAnimating()
            }
        }
    }

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

    lazy var scrollView: UIScrollView = {
        let field = UIScrollView()
        field.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.view.addSubview(field)
        return field
    }()

    lazy var container: UIStackView = {
        let field = UIStackView()
        self.scrollView.addSubview(field)
        field.axis = .vertical
        field.distribution = .fillEqually
        field.alignment = .fill
        field.spacing = 15
        return field
    }()

    lazy var firstNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name"
        field.autocorrectionType = .no
        return field
    }()

    lazy var lastNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.autocorrectionType = .no
        return field
    }()

    lazy var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.autocorrectionType = .no
        return field
    }()

    lazy var passwordField: UITextField = {
        let field = UITextField()
        self.view.addSubview(field)
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        return field
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accent
        button.setTitle("Create Account", for: .normal)
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
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

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.title = "Sign Up"
        self.view.backgroundColor = .white

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(30)
            make.top.bottom.equalTo(self.scrollView).inset(20)
        }

        self.container.addArrangedSubview(firstNameField)
        self.container.addArrangedSubview(lastNameField)
        self.container.addArrangedSubview(emailField)
        self.container.addArrangedSubview(passwordField)
        self.container.addArrangedSubview(registerButton)
        self.container.addArrangedSubview(backButton)
    }

    @objc
    func registerTapped() {
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(message: "Please fill out all fields.")
            return
        }

        manager.register(firstName: firstName, lastName: lastName, email: email, password: password) { [weak self] result in

            guard let `self` = self else { return }
            switch result {
                case .success:
                    //self.present(MainViewController(), animated: true)
                break
                case let .failure(error):
                    self.showAlert(message: error.localizedDescription)
            }
         }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        var userInfo      = notification.userInfo!
        var keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: contentInset.bottom, right: 0)
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc
    func goBack(){
        self.present((UINavigationController(rootViewController: WelcomeViewController())), animated: true, completion: nil)
    }

    //For error messages
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

