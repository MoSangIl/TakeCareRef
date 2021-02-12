//
//  LoginViewController.swift
//  take_care_refrigerator
//
//  Created by SangIl Mo on 2021/02/06.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appleLoginBtnContainer: UIView!
    
    let appleLoginBtn = ASAuthorizationAppleIDButton(type: .continue, style: .whiteOutline)
    // type: 로그인 버튼에 어떠한 문구가 들어갈 지
    // style: 로그인 버튼의 색상
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingAppleLoginBtn()
    }
    
    func settingAppleLoginBtn(){
        appleLoginBtn.cornerRadius = 0
        appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtnContainer.addSubview(appleLoginBtn)
        appleLoginBtn.topAnchor.constraint(equalTo: appleLoginBtnContainer.topAnchor).isActive = true
        appleLoginBtn.bottomAnchor.constraint(equalTo: appleLoginBtnContainer.bottomAnchor).isActive = true
        appleLoginBtn.leftAnchor.constraint(equalTo: appleLoginBtnContainer.leftAnchor).isActive = true
        appleLoginBtn.rightAnchor.constraint(equalTo: appleLoginBtnContainer.rightAnchor).isActive = true
        
        setupEvents()
    }
    
    func setupEvents() {
        appleLoginBtn.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }


    @objc fileprivate func appleLogin() {
            
        let appleIdRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIdRequest.requestedScopes = [.email, .fullName]

        let controller = ASAuthorizationController(authorizationRequests: [appleIdRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}


extension LoginViewController: ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // TODO
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userEmail = credential.email ?? ""
            let familyName = credential.fullName?.familyName ?? ""
            let givenName = credential.fullName?.givenName ?? ""

            let userIdentifier = credential.user
            
            print(userEmail, familyName, givenName, userIdentifier)
            // 가입/로그인 로직...
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle error
    }
}
