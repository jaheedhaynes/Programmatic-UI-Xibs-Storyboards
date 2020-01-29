//
//  showAlert.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Jaheed Haynes on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit


extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
