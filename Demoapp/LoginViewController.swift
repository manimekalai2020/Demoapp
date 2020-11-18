//
//  ViewController.swift
//  Forms
//
//  Created by Bart Jacobs on 04/05/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class LoginViewController: ViewController {

    @IBOutlet weak var Usernamevalidationlabel: UILabel!
    // MARK: - Properties
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var textFieldss: [UITextField]!
    @IBOutlet var passwordValidationLabel: UILabel!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Usernamevalidationlabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidationLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = emailTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: Usernamevalidationlabel.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: saveButton.rx.isEnabled)
            
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
        // Setup View
       // setupView()
        saveButton.cornerRadius = 15
        // Register View Controller as Observer
      //  NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    func showAlert() {
               
    }
    @IBAction func Login_Action(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Homeviewcontroller") as? Homeviewcontroller
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - View Methods

    fileprivate func setupView() {
        // Configure Save Button
        saveButton.isEnabled = false
        saveButton.backgroundColor  = UIColor.gray
        // Configure Password Validation Label
        passwordValidationLabel.isHidden = true
    }

    // MARK: - Notification Handling

    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true

        for textField in textFieldss {
            // Validate Text Field
            let (valid, _) = validate(textField)

            guard valid else {
                formIsValid = false
                break
            }
        }
        if formIsValid == true {
            self.passwordValidationLabel.isHidden = true

            saveButton.backgroundColor = UIColor.blue
            
        }else{
            saveButton.backgroundColor = UIColor.gray

        }
        // Update Save Button
        saveButton.isEnabled = formIsValid
        
    }

    // MARK: - Helper Methods

    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == passwordTextField {
            return (text.count >= 8 && text.count <= 15,  "Your password length need be above 7 and below 15.")
        }

        return (text.count > 0, "This field cannot be empty.")
    }
    

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
       
        case emailTextField:
            let textset = textField.text ?? ""
            if textset.isValidEmail() {
                self.passwordValidationLabel.isHidden = true
                 passwordTextField.becomeFirstResponder()
            }else{
                self.passwordValidationLabel.isHidden = false
                self.passwordValidationLabel.text = "Enter valid email address"
                
            }

            
        case passwordTextField:
            // Validate Text Field
            let (valid, message) = validate(textField)

            self.passwordValidationLabel.text = message

            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordValidationLabel.isHidden = valid
            })
        default:
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

