//
//  ViewController.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 24.05.22.
//

import Firebase
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended
import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController, NVActivityIndicatorViewable {
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
        setUpAnimation()
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
                self?.stopAnimating()
            } else {
                self?.dispalyWarningLabel(withText: "Something wrong")
            }
        }
        loginTF.text = ""
        passwordTF.text = ""
    }

    @IBAction func registrationBtn() {
        setUpAnimation()
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
                self?.stopAnimating()
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

    private func setUpAnimation() {
        startAnimating(
            CGSize(width: 40, height: 40),
            message: "Please wait..",
            type: .ballClipRotateMultiple,
            color: .black
        )
    }
}

// MARK: UITextFieldDelegate

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
