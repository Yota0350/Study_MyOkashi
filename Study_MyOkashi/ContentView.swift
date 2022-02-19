//
//  ContentView.swift
//  Study_MyOkashi
//
//  Created by Yota on 2022/02/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var okashiDataList = OkashiData()
    
    @State var inputText = ""
    
    var body: some View {
        VStack{
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    Task{
                        await okashiDataList.searchOkashi(keyword: inputText)
                    }
                }
                .submitLabel(.search)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
