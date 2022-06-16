//
//  ViewController.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 24.05.22.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {
    // MARK: Internal

    var ref: DatabaseReference!

    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var loginTF: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var errorLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpAnimation.addAnimations("nasa_2", imageView)
        ref = Database.database().reference(withPath: "users")
    }

    @IBAction func loginBtn(_: Any) {
        guard let email = loginTF.text,
              let password = passwordTF.text,
              !email.isEmpty, !password.isEmpty
        else {
            dispalyWarningLabel(withText: "Empty value")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.dispalyWarningLabel(withText: "Registration error: \(error.localizedDescription)")
            } else if let _ = user {
                self?.selectVC(vc: MainPageVC(), storyboard: .main)
            } else {
                self?.dispalyWarningLabel(withText: "Something wrong")
            }
        }
        loginTF.text = ""
        passwordTF.text = ""
    }

    @IBAction func registrationBtn() {
        guard let email = loginTF.text,
              let password = passwordTF.text,
              !email.isEmpty, !password.isEmpty
        else {
            dispalyWarningLabel(withText: "Empty value")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.dispalyWarningLabel(withText: "Registration error: \(error.localizedDescription)")
            } else if let user = user {
                let userRef = self?.ref.child(user.user.uid)
                userRef?.setValue(["email": user.user.email])
                self?.selectVC(vc: MainPageVC(), storyboard: .main)
            }
        }
        loginTF.text = ""
        passwordTF.text = ""
    }

    // MARK: Private

    private func dispalyWarningLabel(withText text: String) {
        errorLbl.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.errorLbl.alpha = 1
        } completion: { [weak self] _ in
            self?.errorLbl.alpha = 0
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === loginTF {
            passwordTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
