//
//  Home_store.swift
//  Ecomercie concept
//
//  Created by Georgy on 23.08.2022.
// Главное окно, Обработка двух collectionView, TextField, Get запросы к API

import UIKit
import Foundation

extension UIColor {//Расширение для перервода HEX в RGb
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int){
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
extension UIImageView {// Расширение для скачивания картинок по URL
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



class Home_store: UIViewController, UICollectionViewDataSource,UITextFieldDelegate, UICollectionViewDelegate {
var cells: Response?
    //* Инициализация CollectionView1(Карусель) и CollectionView2(Группа)
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
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "ProductDetailController") as! ProductDetailController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
 
   //*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Откинуть клавиатуру
        textField.resignFirstResponder()
                 // Распечатать значение в текстовом поле
        print(textField.text!)
        return true;
    }
    



    @IBOutlet weak var Search1: UITextField!

    @IBOutlet var ButtonsUpBar: [UIButton]! // Коллекция кнопок-категорий над строкой поиска
    
   
    @IBOutlet weak var CarouselView: UICollectionView!
    
    @IBOutlet weak var GroupCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //* Инициализаторы
        CarouselView.dataSource = self
        GroupCollectionView.delegate = self
        GroupCollectionView.dataSource = self
        Search1.delegate = self
        //*
        
        //* Иконка поиска слева от TextField(Строка поиска)
        let findTextFieldImageView = UIImageView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        let image = UIImage(named: "Search_Icon.png")
        findTextFieldImageView.image = image
        findTextFieldImageView.contentMode = .scaleAspectFit
        findTextFieldImageView.tintColor = .gray
        findTextFieldImageView.backgroundColor = .clear
        let findTextFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 40))
        findTextFieldView.addSubview(findTextFieldImageView)
        findTextFieldView.backgroundColor = .clear
        Search1.leftViewMode = UITextField.ViewMode.always
        Search1.leftView = findTextFieldView
        //*
        
        //* Обработчик прерываний для Get запроса
        let url1=URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        getData(from: url1!) { json in
            print(json.best_seller[0].discount_price)
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
        
        //* Get запрос
        func getData(from url:URL, completion:@escaping(_:Response)->()){
            let task = URLSession.shared.dataTask(with: url){data,response,error in
             
                guard let data = data, error == nil else{
                    print("something wrong")
                    return
                }
                
                //have data
                var result:Response?
                do {
                    result = try JSONDecoder().decode(Response.self, from: data)
                }
                catch{
                    print("failed to convert \(error.localizedDescription)")
                }
                
              guard let json = result else{
                    return
              }
            completion(json)
              
            }
            task.resume()
        }
        //*

    }
   
    @IBAction func IfTapped(_ sender: UIButton) {//Кнопки красятся в ScrollView
        for i in ButtonsUpBar{
            i.backgroundColor = .systemGray4
        }
        let color1 = UIColor(rgb:0xFF6E4E)
        sender.backgroundColor = color1
       
        
    }
    
    
   
}
