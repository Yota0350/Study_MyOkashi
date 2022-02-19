//
//  ContentView.swift
//  Study_MyOkashi
//
//  Created by Yota on 2022/02/19.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var okashiDataList = OkashiData()
    
    @State var inputText = ""
    @State var showSafari = false
    
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
            
            List(okashiDataList.okashiList){ okashi in
                Button(action: {
                    showSafari.toggle()
                }){
                    HStack{
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
                .sheet(isPresented: self.$showSafari, content: {
                    SafariView(url: okashi.link)
                        .edgesIgnoringSafeArea(.bottom)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
