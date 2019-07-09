//
//  APIManager.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit

class APIManager {
    
    func loadJsonFromUrl() -> Data? {
        do {
            let url = URL(string: "https://camper-app.herokuapp.com/api/v1/sites")!
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    func deserializeData(loadedData: Data, onCompletion: @escaping (_ campers: [CamperDataModel]) -> Void){
        DispatchQueue.global().async {
            do {
                let decoder = JSONDecoder()
                let campersDecoded = try decoder.decode(ApiResponse.self, from: loadedData)
                DispatchQueue.main.async {
                    onCompletion(campersDecoded.sites)
                }
            } catch {
                print(error)
            }
        }
    }
  
    func addData(name: String, lat: Double, long: Double, onCompletion: @escaping (Bool) -> Void) {
        let reqUrl = "https://camper-app.herokuapp.com/api/v1/site/"
        var request  = URLRequest(url: URL(string: reqUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters : [String: Any] = [
            "name": name,
            "latitude": lat,
            "longitude": long
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = data as Data

        let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
//            sleep(4) //simulates a 4 second API call
            if let error = error {
                print(error)
            }
            else {
                print("insert call success")
            }
            DispatchQueue.main.async {
                onCompletion(true)
            }
        }
        dataTask.resume()
    }
    
    func updateData(id: Int?, name: String?, onCompletion: @escaping (Bool) -> Void) {
        let reqUrl = "https://camper-app.herokuapp.com/api/v1/site/"
        guard let idToUpdate = id, let nameToUpdate = name else { return }
        let id = String(idToUpdate)
        let finalUrl = reqUrl + id
        var request  = URLRequest(url: URL(string: finalUrl)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters : [String: Any] = [
            "name": nameToUpdate
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = data as Data
        
        let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
//            sleep(4) //simulates a 4 second API call
            if let error = error {
                print(error)
            }
            else {
                print("update call success")
            }
            DispatchQueue.main.async {
                onCompletion(true)
            }
        }
        dataTask.resume()
    }

}
