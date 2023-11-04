//
//  UserViewModel.swift
//  Dota2 Hero
//
//  Created by Bandit Silachai on 4/11/23.
//

import Foundation

class HeroViewModel {
    private var hero: Hero?
    
    func getHeroes(onComplete: @escaping(Result<[Hero], Error>) -> Void ) {
        guard let url = URL(string: "https://dota2-heroes-api.vercel.app/heroes") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                onComplete(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result =  try decoder.decode([Hero].self, from: data)
                onComplete(.success(result))
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
