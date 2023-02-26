//
//  ContentView.swift
//  CatFacts
//
//  Created by Don Bouncy on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var fc = FactController()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Image(fc.error ? "sad" : "cat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: fc.error ? 50 : 100)
                    Text(fc.error ? "Couldn't fetch fact" : fc.fact?.fact ?? "")
                        .padding()
                }
            }
            .padding()
            .frame(width: 400, height: 500)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .padding()
                    .shadow(color: .black.opacity(0.1), radius: 8, x: -8, y: 8)
                
            )
            .task {
                await fc.loadData()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        Task {
                            await fc.loadData()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .padding()
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
