//
//  ViewController.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {

    lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
        return imageView
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        self.view.addSubview(button)
        button.backgroundColor = .accent
        button.setTitle("Log in ", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton()
        self.view.addSubview(button)
        button.backgroundColor = .accent
        button.setTitle("Create an Account", for: .normal)
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.barTintColor = .primary
        self.navigationController?.navigationBar.tintColor = .white

        self.title = "Servpal"

        self.view.backgroundColor = .white

        logo.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(100)
            make.size.equalTo(180)
        }

        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(20)
            make.height.equalTo(40)
        }

        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(20)
            make.height.equalTo(40)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-40)
        }
    }

    @objc
    func loginTapped() {
        self.present(UINavigationController(rootViewController: LoginViewController()), animated: true)
        
    }

    @objc
    func registerTapped() {
        self.present(UINavigationController(rootViewController: RegisterViewController()), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

