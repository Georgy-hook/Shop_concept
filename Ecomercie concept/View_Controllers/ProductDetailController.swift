//
//  ProductDetailController.swift
//  Ecomercie concept
//
//  Created by Georgy on 23.09.2022.
// Детали телефона, get запрос и его обработка в CollectionView и Label, реализация рейтинговых звезд, а также поддержка кликабельности кнопок выбора деталей

import UIKit

class ProductDetailController: UIViewController,UICollectionViewDataSource {
    var detail : Details?
    var IsFavorite = false

    @IBOutlet var Stars: [UIButton]!
    
    
    @IBOutlet var Categories: [UIButton]!
    
    
    @IBOutlet var ChooseColor: [UIButton]!
    
    @IBOutlet var ChooseCapacity: [UIButton]!
    
    @IBOutlet weak var CPUShow: UILabel!
    
    @IBOutlet weak var CameraShow: UILabel!
    
    @IBOutlet weak var SDShow: UILabel!
    
    @IBOutlet weak var SSDShow: UILabel!
    
    
    @IBOutlet weak var LikeBtn: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
      
        guard detail == nil else {
            cell.PhoneImage.downloaded(from: (detail?.images[indexPath.item])!)
            return cell
        }
        return cell
    }
    


    @IBOutlet weak var ProductCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollection.dataSource = self
        //* Первоначальное состояние категорий
        Categories[0].setAttributedTitle(MakeText(type: "underLineShop"), for: .normal)
        Categories[1].setAttributedTitle(MakeText(type: "DefaultDetails"), for: .normal)
        Categories[2].setAttributedTitle(MakeText(type: "DefaultFeatures"), for: .normal)
        //*
        //* Обработка прерываний
        let url1=URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")
        Connect().getDataDetails(from: url1!) { json in
            self.detail = json
            var indexPath = IndexPath(item: 0, section: 0)
            OperationQueue.main.addOperation({ [self] in
                for _ in 0...1{
                    if let cell = self.ProductCollection.cellForItem(at: indexPath) as? DetailsCell{
                        cell.PhoneImage.downloaded(from: json.images[indexPath.item])
                    }
                    indexPath.item+=1
                }
                CPUShow.text = detail?.CPU
                CameraShow.text = detail?.camera
                SDShow.text = detail?.sd
                SSDShow.text = detail?.ssd
            })
        }

        //* Отображаем был ли лайкнут телефон на который мы перешли
        if IsFavorite == true {
            LikeBtn.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        }
        //*
   
    }
    

    @IBAction func PushRoot(_ sender: Any) {//Возврат на Home_store
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func RatingStar(_ sender: UIButton) {//Функция для оценки телефона звездочками
        for i in sender.tag...4{
            Stars[i].setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        }
        for i in 0...sender.tag{
            Stars[i].setImage(UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        }
    }
    
    
    @IBAction func SwitchCategories(_ sender: UIButton) {// Меняем категории путем подчеркивания нужной при нажатии
        
        switch sender.tag{

        case 0:
            Categories[0].setAttributedTitle(MakeText(type: "underLineShop"), for: .normal)
            Categories[1].setAttributedTitle(MakeText(type: "DefaultDetails"), for: .normal)
            Categories[2].setAttributedTitle(MakeText(type: "DefaultFeatures"), for: .normal)
        case 1:
            Categories[0].setAttributedTitle(MakeText(type: "DefaultLineShop"), for: .normal)
            Categories[1].setAttributedTitle(MakeText(type: "underLineDetails"), for: .normal)
            Categories[2].setAttributedTitle(MakeText(type: "DefaultFeatures"), for: .normal)
        case 2:
            Categories[0].setAttributedTitle(MakeText(type: "DefaultLineShop"), for: .normal)
            Categories[1].setAttributedTitle(MakeText(type: "DefaultDetails"), for: .normal)
            Categories[2].setAttributedTitle(MakeText(type: "underLineFeatures"), for: .normal)
        default:
         return
        }
    }
    
    
    @IBAction func ChooseColor(_ sender: UIButton) {// Выбор цвета
        for i in 0...1 {
            ChooseColor[i].setImage(UIImage(), for: .normal)
        }
        sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
    }
    
    
    @IBAction func ChooseCapacity(_ sender: UIButton) { // Выбор памяти
        for capacity in ChooseCapacity{
            capacity.backgroundColor = .white
            capacity.setTitleColor(.black, for: .normal)
        }
        sender.backgroundColor = UIColor(rgb: 0xFF6E4E)
        sender.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func LikeMe(_ sender: UIButton) {
    }
    
    
    @IBAction func ShowCart(_ sender: UIButton) { // Открыть корзину
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "CartController") as! CartController
        nextViewController.detail = detail!
            navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func AddToCart(_ sender: UIButton) {
        Ecomercie_concept.Cart+=1
    }
}
