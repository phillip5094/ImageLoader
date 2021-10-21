//
//  ProgressBar.swift
//  ImageLoader
//
//  Created by Philip on 2021/10/21.
//

import SwiftUI

struct ProgressBar: View {
    var bgColor: Color = .blue
    var ratio: CGFloat
    
    var body: some View {
        GeometryReader { geometryProxy in
            RoundedRectangle(cornerRadius: 20)
                .stroke(bgColor, lineWidth: 2)
                .frame(width: geometryProxy.size.width)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(bgColor)
                .frame(width: geometryProxy.size.width * min(ratio, 1.0))
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(bgColor: .black, ratio: 0.5)
    }
}
