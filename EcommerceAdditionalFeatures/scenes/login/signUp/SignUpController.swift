//
//  SignUpController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import Foundation

class SignUpController: Controller<SignUpViewModel, LoginNavigationController> {
    
    
    private let nameTextField = TextFieldLayout()
    private let surnameTextField = TextFieldLayout()
    private let emailTextField = TextFieldLayout()
    private let passwordTextField = TextFieldLayout()
    private let againPasswordTextField = TextFieldLayout()
 //   private let segmentView = SegmentView<UserType>()
    private let registerButton = ButtonPrimary()
    private let loginButton = ButtonSecondary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews(nameTextField, surnameTextField, emailTextField, passwordTextField, againPasswordTextField, registerButton, loginButton)
        
        activateConstraints(
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            againPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            againPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            registerButton.topAnchor.constraint(equalTo: againPasswordTextField.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        )
    }
    
    
    override func customizeViews() {
        nameTextField.placeholder = "Name"
        surnameTextField.placeholder = "Surname"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        againPasswordTextField.placeholder = "Again Password"
        
        passwordTextField.isSecureTextEntry = true
        againPasswordTextField.isSecureTextEntry = true
        
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.action = registerButtonClicked
        
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.action = signInButtonClicked
    }
    
    
    private func registerButtonClicked() {
        guard
            let name = nameTextField.text, !name.isEmpty,
            let surname = surnameTextField.text, !surname.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let againPassword = againPasswordTextField.text, !againPassword.isEmpty
        else {
            return
        }
        let user = User(uid : nil, name: name, surname: surname, email: email)
        
       /* viewModel.registerUser(email: email, password: password, againPassword: againPassword, name: name, surname: surname) {
            self.navController?.leaveFromLogin()
        } */
        
        viewModel.registerUser(email: user.email!, password: password, againPassword: againPassword, name: user.name!, surname: user.surname!) {
            self.navController?.leaveFromLogin()
        }
    }
    
    
    private func signInButtonClicked(){
        navController?.signUpToSignIn()
    }
}

