//
//  LoginViewController.swift
//  Cat
//
//  Created by Shuwen Li on 01/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var labelErrorMessage: UILabel!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    let loginService = LoginService()
    private let loginViewModel = LoginViewModel()
    var loginSuccessHandler: ((LoginKey) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelErrorMessage.text = loginViewModel.loginErrorMessage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTouched(_ sender: Any) {
        let name = textFieldName.text!
        let password = textFieldPassword.text!
        
        let credential = LoginCredential(password: password, username: name)
        loginService.performLogin(credential: credential, success: loginSuccess, failure: loginFailure)
    }
    
    private func loginSuccess(loginKey: LoginKey) {
        loginSuccessHandler?(loginKey)
        dismiss(animated: true, completion: nil)
    }
    
    private func loginFailure(error: APIError) {
        loginViewModel.loginError = error
        DispatchQueue.main.async {
            self.labelErrorMessage.text = self.loginViewModel.loginErrorMessage
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
