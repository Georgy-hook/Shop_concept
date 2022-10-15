//
//  CartController.swift
//  Ecomercie concept
//
//  Created by Georgy on 30.09.2022.
// Окно Корзины,Удаление элементов, подсчет цены всех элементов(в зависимости от количества самих элементов и количество позиций в каждом элементе)

import UIKit

class CartController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var detail:Details!
    var total = 0
    var currentPrice: Int?
    @IBOutlet weak var CartTableView: UITableView!
    
    @IBOutlet weak var TotalLabel: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        guard detail == nil else{
            if Int(cell.Price.text ?? "0") ?? 0 < detail.price{
                cell.PhoneImage.downloaded(from: detail.images[0])
                cell.DeleteButton.tag = indexPath.row
                cell.IncrementButton.tag = indexPath.row
                cell.DecrementButton.tag = indexPath.row
                cell.price = detail.price
                cell.Price.text = String(detail.price)
                total+=Int(cell.Price.text!)!
                TotalLabel.text = String(total)
                cell.price = Int(cell.Price.text!)!
            }
            else {
                cell.DeleteButton.tag = indexPath.row
                cell.IncrementButton.tag = indexPath.row
                cell.DecrementButton.tag = indexPath.row
            }
            return cell
        }
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CartTableView.dataSource = self
        CartTableView.delegate = self
        currentPrice = detail.price
    }
    

    

    @IBAction func BackPlease(_ sender: UIButton) {
       navigationController?.popViewController(animated: true)
    }
    @IBAction func DeleteRow(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        Cart-=1
        let cell = CartTableView.cellForRow(at: indexPath) as? CartCell
        total-=Int(cell!.Price.text!)!
        TotalLabel.text = String(total)
        CartTableView.deleteRows(at: [indexPath], with:.automatic)
        CartTableView.reloadData()
       

    }
    
    @IBAction func ac(_ sender: UIButton) {
        total += detail.price
        TotalLabel.text = String(total)
        
    }
    
    @IBAction func Decrement(_ sender: UIButton) {

        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = CartTableView.cellForRow(at: indexPath) as? CartCell
        if cell!.CountPhone>1 {
            total -= detail.price
            TotalLabel.text = String(total)
        }
    }
}
