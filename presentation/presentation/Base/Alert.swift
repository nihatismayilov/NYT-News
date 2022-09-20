//
//  Alert.swift
//  presentation
//
//  Created by Nihad Ismayilov on 16.09.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlertMessage(messageToDisplay: String, title: String, actions: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction!) in
            actions!()
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
