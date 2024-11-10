//
//  ContentView.swift
//  urlscheme share
//
//  Created by Huy Nguyen on 4/11/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var pathInput: String = ""
    @State private var isShowingShareSheet = false
    @State private var textToShare: String = ""

    var body: some View {
        ZStack {
            Image("img")
                .resizable()
                .scaledToFill()
                .opacity(0.65)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("urlscheme share")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                Text("From 34306 with love")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack(spacing: 20) {
                    TextField("Enter path", text: $pathInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 70)
                    
                    Button(action: {
                        textToShare = "file://a\(pathInput)"
                    
                        UIPasteboard.general.string = textToShare
                    
                        isShowingShareSheet = true
                    }) {
                        Text("Export")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                    .sheet(isPresented: $isShowingShareSheet) {
                        ActivityView(activityItems: [textToShare])
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

// Helper for share sheet
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        controller.modalPresentationStyle = .pageSheet
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
