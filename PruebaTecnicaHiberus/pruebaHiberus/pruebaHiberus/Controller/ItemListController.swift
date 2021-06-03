//
//  ItemListViewController.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/1/21.
//

import UIKit

class ItemListController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cardsTableView: UITableView!
    let serviceCard = CardListService()
    var cardList :[Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Lista de tarjetas"
        showTableView(false)
        registerTableViewCell()
        getListCard()
    }
    
    private func registerTableViewCell() {
        let cell = UINib(nibName: "CardCell", bundle: nil)
        self.cardsTableView.register(cell, forCellReuseIdentifier: "CardCell")
    }
    
    func showTableView(_ value: Bool){
        self.cardsTableView.isHidden = !value
    }
    
    // MARK: - Consume - web services
    func getListCard(){
        self.showHUD(self.view)
        serviceCard.getCardList { [self] (response, error) in
            if error == nil {
                self.cardList = response?.cards ?? []
                self.showTableView((self.cardList.count>0))
                self.cardsTableView.reloadData()
            }else {
                self.showAlert(error, titulo: nil)
            }
            self.hideHUD(self.view)
        }
    }
    
    // MARK: - UITableView Delegate && DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        let card = cardList[indexPath.row]
        cell.lbName.text = card.name
        cell.lbNanacost.text = card.manaCost
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailController()
        let card = cardList[indexPath.row]
        vc.card = card
        self.navigationController?.pushViewController(vc, animated: true)
        
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
