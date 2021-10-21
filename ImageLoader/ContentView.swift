//
//  ContentView.swift
//  ImageLoader
//
//  Created by Philip on 2021/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var ratio: CGFloat = 0.0
    @State var image: Image?
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    image = try! await data(from: URL(string: "https://source.unsplash.com/random/1000x1000")!)
                }
            }) {
                Text("Load Image")
            }
            ProgressBar(ratio: ratio)
                .frame(height: 20)
                .padding()
            
            HStack {
                if ratio < 1.0 {
                    ProgressView()
                    
                } else {
                    image?
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 300, height: 300)
        }
    }
    
    func data(from url: URL) async throws -> Image {
        let (asyncBytes, urlResponse) = try await URLSession.shared.bytes(for: URLRequest(url: url))

        let length = Int(urlResponse.expectedContentLength)
        var data = Data()
        data.reserveCapacity(length)
        
        for try await byte in asyncBytes {
            data.append(byte)
            let progress = CGFloat(data.count) / CGFloat(length)
            ratio = progress
        }
        
        return Image(uiImage: UIImage(data: data)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
