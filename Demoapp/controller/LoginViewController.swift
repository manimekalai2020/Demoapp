

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
        passwordValidationLabel.text = "Password has to be above 4 and below 15 characters"
        
        let usernameValid = emailTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength  && $0.count <= 15 }
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

        saveButton.cornerRadius = 15

    }
    func showAlert() {
               
    }
 
}
    // MARK: - View Methods

   

