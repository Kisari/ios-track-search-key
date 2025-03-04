//
//  ContentView.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 3/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = KeyWordViewModel(keyWordManager: .init(capacity: 4))
    @State private var newKeyWordText: String = ""

    var body: some View {
        VStack {
            TextField("Enter new keyword", text: $newKeyWordText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    if !newKeyWordText.isEmpty {
                        let newKeyWord = KeyWord(key: newKeyWordText)
                        viewModel.processKeyWord(newKeyWord)
                        newKeyWordText = ""
                    }
                }

            List {
                ForEach(viewModel.keyWordList, id: \.self.id ) { keyWord in
                    HStack {
                        Text(keyWord.key)
                    }
                    .padding()
                }
            }
            .listStyle(PlainListStyle())

            Text("Current size: \(viewModel.currentSize)")
                .padding()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
