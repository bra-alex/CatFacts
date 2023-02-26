//
//  CatController.swift
//  CatFacts
//
//  Created by Don Bouncy on 26/02/2023.
//

import Foundation

struct CatFact: Codable{
    let fact: String
}

class FactController: ObservableObject{
    @Published var fact: CatFact?
    @Published var error = false
    
    func loadData() async {
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            print("Couldn't find resource")
            return
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let res = response as! HTTPURLResponse
            
            if res.statusCode == 200 {
                if let decodedData = try? JSONDecoder().decode(CatFact.self, from: data){
                    fact = decodedData
                    error = false
                }
            } else {
                error = true
            }
        } catch {
            DispatchQueue.main.async {
                self.error = true
            }
            print(error.localizedDescription)
        }
        
    }
}
