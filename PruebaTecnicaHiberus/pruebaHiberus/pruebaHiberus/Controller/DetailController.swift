//
//  DetailController.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailController: UIViewController {

    @IBOutlet weak var lbCardName: UILabel!
    @IBOutlet weak var imgViewCard: UIImageView!
    @IBOutlet weak var txtViewDetail: UITextView!
    
    var card : Card?
    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalle"

        // Do any additional setup after loading the view.
        self.loadData()
        self.downloadImage()
    }
    
    // MARK: - Load data
    func loadData(){
        lbCardName.text = card?.name
        txtViewDetail.text = card?.text
    }
    
    func downloadImage() {
        if(card?.imageUrl!.count ?? 0 > 0){
            let imageUrl = card?.imageUrl
            if loadImageCache(imageUrl!) {
                loadImage(imageUrl!)
            }else {
                AF.request( imageUrl!, method: .get).response{ response in
                    switch response.result {
                    case .success(let responseData):
                        let image = UIImage(data: responseData!, scale:1)
                        self.imageCache.add(image!, withIdentifier:imageUrl! )
                        self.loadImage(imageUrl!)
                    case .failure(let error):
                        self.showAlert("Imagen no disponible", titulo: nil)
                        print("error--->",error)
                    }
                }
            }
           
        }
    }
    
    func loadImage(_ imageUrl:String) {
        if  let image = imageCache.image (withIdentifier: imageUrl) {
            self.imgViewCard.image = image
        }
    }
    
    func loadImageCache( _ imageUrl:String) -> Bool {
        if  imageCache.image (withIdentifier: imageUrl) != nil {
            return true
        }else {return false}
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
