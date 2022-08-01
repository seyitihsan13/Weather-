//
//  DetailViewController.swift
//  123412
//
//  Created by İhsan Elkatmış on 18.07.2022.
//

import Foundation

//
//  DetailViewController.swift
//  HavaDurumu
//
//  Created by İhsan Elkatmış on 30.06.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var city = String()
    var feels = String()
    
    //let api = "da6e9d2bb94395b98a17c1d20444f828"
    
   // let lat = "41.031464"
    
   // let lon = "40.5466095"
    
   // var citylist : Array<City> = Array()
    


    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var feel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName.text = city
        self.feel.text = feels
        getTodayResult()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getTodayResult() {
        
      if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=8cf8aa011222f20dd1c4b02378dbe866") {
            print(url)
            let request = URLRequest(url: url)
          
          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                          
                          if error == nil {
                              
                              if let incomingData = data {
                                  
                                  do {
                                      
                                      let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                      
                                      //print(json)
                                      
                                      if let main = json["main"] as? NSDictionary {
                                          
                                          if let temp = main["temp"] as? Double {
                                             
                                              let state = Int(temp - 273.15)
                                              
                                              DispatchQueue.main.sync {
                                                  self.weather.text = String(state)
                                              }
                                              
                                          }
                                          
                                      }
                                      if let main = json["main"] as? NSDictionary {
                                          
                                          if let feels_like = main["feels_like"] as? Double {
                                              
                                              let deneme = Int(feels_like - 273.15)
                                              
                                              DispatchQueue.main.sync {
                                                  self.feel.text = String(deneme)
                                              }
                                              
                                          }
                                          
                                      }
                                      
                                  }catch{
                                      print("bir hata oluştu.")
                                  }
                                  
                              }
                              
                          }
                          
                      }
                      task.resume()
                      
                  }
                  
                  
              }


          }
