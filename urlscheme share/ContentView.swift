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
            // Background Image with 65% opacity
            Image("img")
                .resizable()
                .scaledToFill()
                .opacity(0.65)
                .ignoresSafeArea() // Extends the image to cover the entire screen
            
            VStack(spacing: 20) {
                // Title
                Text("urlscheme share")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                Text("by 34306")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack(spacing: 20) {
                    // Main content with 20-pixel horizontal padding
                    TextField("Enter path", text: $pathInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 70) // Adds 20-pixel padding from left and right
                    
                    Button(action: {
                        // Generate the URL text
                        textToShare = "file://a\(pathInput)"
                        
                        // Copy to clipboard
                        UIPasteboard.general.string = textToShare
                        
                        // Show the share sheet
                        isShowingShareSheet = true
                    }) {
                        Text("Export")
                            .font(.title2) // Title font size
                            .fontWeight(.bold) // Bold text
                            .foregroundColor(Color.yellow)
                    }
                    .sheet(isPresented: $isShowingShareSheet) {
                        ActivityView(activityItems: [textToShare])
                            .presentationDetents([.medium]) // Specifies a half-screen height
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
        
        // Configure the presentation style to use .pageSheet, which defaults to half-screen
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
