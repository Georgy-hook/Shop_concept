//
//  Get_Json_Data.swift
//  Ecomercie concept
//
//  Created by Georgy on 02.01.2023.
// Подключение к API в дальнейшем в программе используется через замыкания 

import Foundation

class Connect{
    
    var Home:Response? = nil
    func getDataResponse(from url:URL, completion:@escaping(_:Response)->()){
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
            self.Home = json
        }
        task.resume()
    }
    
    
    
    func getDataDetails(from url:URL, completion:@escaping(_:Details)->()){
        let task = URLSession.shared.dataTask(with: url){data,response,error in
            
            guard let data = data, error == nil else{
                print("something wrong")
                return
            }
            
            //have data
            var result:Details?
            do {
                result = try JSONDecoder().decode(Details.self, from: data)
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
    
    }

//*
