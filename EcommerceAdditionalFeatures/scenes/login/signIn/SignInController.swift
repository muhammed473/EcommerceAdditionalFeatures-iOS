//
//  SignInController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class SignInController: Controller<SignInViewModel, LoginNavigationController> {
    
    private let emailText = TextFieldLayout()
    private let passwordText = TextFieldLayout()
    private let signInButton = ButtonPrimary()
    private let signUpButton = ButtonSecondary()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailText.text = nil
        passwordText.text = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addSubviews(emailText, passwordText, signInButton, signUpButton)
        
        activateConstraints(
            emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            
            passwordText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 20),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        )
        
        view.backgroundColor = .white
    }
    
    
    override func customizeViews() {
        emailText.placeholder = "Email"
        passwordText.placeholder = "Password"
        
        passwordText.isSecureTextEntry = true
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.action = signInButtonClicked
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.action = signUpButtonClicked
    }
    
    
    private func signInButtonClicked() {
        guard
            let email = emailText.text, !email.isEmpty,
            let password = passwordText.text,!password.isEmpty
        else {
            return
        }
        viewModel.signIn(email: email, password: password) { [weak self] user in
            self?.navController?.leaveFromLogin()
        }
    }
    
    
    private func signUpButtonClicked() {
        navController?.signInToSignUp()
    }
}
