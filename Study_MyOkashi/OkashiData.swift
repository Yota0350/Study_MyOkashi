//
//  OkashiData.swift
//  Study_MyOkashi
//
//  Created by Yota on 2022/02/19.
//

import Foundation

class OkashiData: ObservableObject{
    struct ResultJson: Codable{
        struct Item: Codable{
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
    
    func searchOkashi(keyword: String) async{
        print(keyword)
        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        guard let req_url = URL(string:"https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r")
        else{
            return
        }
        
        print(req_url)
        
        do{
            let (data , _) = try await URLSession.shared.data(from: req_url)
            
            let decoder = JSONDecoder()
            
            let json = try decoder.decode(ResultJson.self, from: data)
            
            print(json)
            
        } catch{
            print("エラーが発生しました")
        }
    }
}
