//
//  Home_store.swift
//  Ecomercie concept
//
//  Created by Georgy on 23.08.2022.
// Главное окно, Обработка двух collectionView, TextField, TabBar

import UIKit
import Foundation

class Home_store: UIViewController, UICollectionViewDataSource,UITextFieldDelegate, UICollectionViewDelegate,UITabBarDelegate{
  
    
    
//* Таб бар переход в корзину по нажатию на кнопку | Демонстрация наличия элементов в корзине
    @IBOutlet weak var CustomTabBar: CustomBar!
    @IBOutlet weak var Bag: UITabBarItem!
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "CartController") as! CartController
        if item.tag == 0 {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        Bag.badgeValue = String(Cart)
    }
//*
    
    
    //* Инициализация CollectionView1(Карусель) и CollectionView2(Группа)
    
    @IBOutlet weak var CarouselView: UICollectionView!
    
    @IBOutlet weak var GroupCollectionView: UICollectionView!
    
    var cells = Connect().Home//* Переменная хранящая в себе API
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == CarouselView {
            return 1
        }
        else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CarouselView {
            return 3
        }
        else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CarouselView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CarouselCell
            cell.backgroundColor = .black
            guard cells == nil else {
                cell.Label1.text = cells?.home_store[indexPath.item].title
                cell.BackgroundImage.downloaded(from: (cells?.home_store[indexPath.item].picture)!)
                cell.Label2.text = cells?.home_store[indexPath.item].subtitle
                return cell
            }
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
            cell.backgroundColor = .white
            cell.LabelOldPrice.attributedText = MakeText(type: "strikeThrough")
            guard cells == nil else {
                cell.BackgroundImage.downloaded(from: (cells!.best_seller[indexPath.item].picture))
                cell.LabelPrice.text = "\(cells!.best_seller[indexPath.item].price_without_discount)$"
                cell.LabelOldPrice.text="\(cells!.best_seller[indexPath.item].discount_price)$"
                cell.LabelName.text = "\(cells!.best_seller[indexPath.item].title)"
                return cell
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = GroupCollectionView.cellForItem(at: indexPath) as! GroupCell
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "ProductDetailController") as! ProductDetailController
        if cell.IsLike == true {
            nextViewController.IsFavorite = true
        }
        navigationController?.pushViewController(nextViewController, animated: true)
       
    }
 
   //*
    
    
    
    //* TextField делегат для откидывания клавиатуры и добавление кнопки сбоку
   
    @IBOutlet weak var Search1: UITextField!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Откинуть клавиатуру
        textField.resignFirstResponder()
                 // Распечатать значение в текстовом поле
        print(textField.text!)
        return true;
    }
    
    //*
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //* Инициализаторы
        CarouselView.dataSource = self
        GroupCollectionView.delegate = self
        GroupCollectionView.dataSource = self
        Search1.delegate = self
        CustomTabBar.delegate = self
        //*
        
        //* Обработчик прерываний для Get запроса
        let url1=URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        Connect().getDataResponse(from: url1!) { json in
            OperationQueue.main.addOperation({ [self] in
                
                var indexPath = IndexPath(item: 0, section: 0)
                if let cell = self.CarouselView.cellForItem(at: indexPath) as? CarouselCell{
                    cell.Label1.text = json.home_store[0].title
                    cell.Label2.text = json.home_store[0].subtitle
                    cell.BackgroundImage.downloaded(from: json.home_store[0].picture)

                                    }
                for _ in 0...3 {
                   
                    if let cell = self.GroupCollectionView.cellForItem(at:indexPath) as? GroupCell{
                        cell.BackgroundImage.downloaded(from: json.best_seller[indexPath.item].picture)
                        cell.LabelPrice.text = "\(json.best_seller[indexPath.item].price_without_discount)$"
                        cell.LabelOldPrice.text="\(json.best_seller[indexPath.item].discount_price)$"
                        cell.LabelName.text = json.best_seller[indexPath.item].title
                        indexPath.item += 1
                    }
                }
                cells = json
                               })
        }
        //*

    }
   
@IBOutlet var ButtonsUpBar: [UIButton]! // Коллекция кнопок-категорий над строкой поиска
    
    @IBAction func IfTapped(_ sender: UIButton) {//Кнопки красятся в ScrollView
        for i in ButtonsUpBar{
            i.backgroundColor = .systemGray4
        }
        sender.backgroundColor = UIColor(rgb:0xFF6E4E)
       
        
    }
    
    
   
}
