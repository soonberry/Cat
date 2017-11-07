//
//  MyCatViewController.swift
//  Cat
//
//  Created by Shuwen Li on 01/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import UIKit

class MyCatViewController: UIViewController {

    private let myCatViewModel = MyCatViewModel()
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performLogin()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LoginViewController {
            vc.loginSuccessHandler = loginSuccess
        }
    }
    
    private func performLogin() {
        if myCatViewModel.shouldPerformLogin {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    

    
    private func loginSuccess(loginKey: LoginKey) {
        myCatViewModel.loginKey = loginKey
    }

}
