//
//  LoginViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addTarget()
    }
    
    private func addTarget() {
        loginView.loginBtn.addTarget(self, action: #selector(didTapLoginBtn(_:)), for: .touchUpInside)
    }
    
    
}

extension LoginViewController {
    
    @objc func didTapLoginBtn(_ sender: UIButton) {
        sender.animateTap(scale: 0.95)
        viewModel.showOAuthPrompt(in: self) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = MainTabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            case .failure:
                print("There is a error!!!")
            }
        }
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
