//
//  ViewController.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/1/21.
//

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBAction
    @IBAction func tapIrPantalla2(_ sender: Any){
        let vc = UIStoryboard.init(name: "ItemList", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    


}

