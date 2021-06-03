//
//  Extension.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD(_ toView:UIView){
         MBProgressHUD.showAdded(to:view, animated: true)
//        mode = .intermitente
    }
    
    func hideHUD(_ view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}
