//
//  ItemListViewController.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/1/21.
//

import UIKit

class ItemListController: UIViewController {
    
    let serviceCard = CardListService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getListCard()
    }
    
    // MARK: - Consume - web services
    func getListCard(){
        serviceCard.getCardList { (response, error) in
            if error == nil {
                
                let card =   response?.cards?.first
                self.loadImage((card?.imageUrl)!)
                self.showAlert(card?.name, titulo: nil)
            }else {
                self.showAlert("Ha ocurrido un error, intente más tarde", titulo: nil)
            }
        }
    }
    func loadImage(_ imageUrl : String){
        ClientApiRest.loadImage(imageUrl)
        
    }
    
    
    // MARK: - Alert
    func showAlert(_ mensaje: String?, titulo: String?) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: { action in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
