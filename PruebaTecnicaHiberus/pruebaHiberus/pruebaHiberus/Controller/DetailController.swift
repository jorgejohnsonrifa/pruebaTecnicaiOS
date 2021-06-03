//
//  DetailController.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import UIKit
import Alamofire

class DetailController: UIViewController {

    @IBOutlet weak var lbCardName: UILabel!
    @IBOutlet weak var imgViewCard: UIImageView!
    @IBOutlet weak var txtViewDetail: UITextView!
    
    var card : Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalle"

        // Do any additional setup after loading the view.
        self.loadData()
        self.loadImage()
    }
    

    func loadData(){
        lbCardName.text = card?.name
        txtViewDetail.text = card?.text
    }
    
    func loadImage() {
        if(card?.imageUrl!.count ?? 0 > 0){
            let imageUrl = card?.imageUrl
            AF.request( imageUrl!, method: .get).response{ response in
                switch response.result {
                case .success(let responseData):
                    self.imgViewCard.image = UIImage(data: responseData!, scale:1)
                case .failure(let error):
                    self.showAlert("Imagen no disponible", titulo: nil)
                    print("error--->",error)
                }
            }
        }
    }
    
    // MARK: - Alert
    func showAlert(_ mensaje: String?, titulo: String?) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: { action in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }


}
