//
//  File.swift
//  
//
//  Created by Kai on 2022/1/17.
//

import SwiftUI

public struct RemarkEditor: View {
    @Binding var text: String
    var height: CGFloat
    var labelString: String
    var offsetX: CGFloat
    
    @Environment(\.colorScheme) private var colorScheme
    
    var backgroundColor: Color {
        colorScheme == .light ? .white : .clear
    }
    
    public init(_ labelString: String,
         text: Binding<String>,
         height: CGFloat = 200,
         offsetX: CGFloat = -35) {
        self.labelString = labelString
        _text = text
        self.height = height
        self.offsetX = offsetX
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                MarkdownEditor(source: $text)
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
            }
            .border(Color.gray.opacity(0.3))
                
            Text(labelString)
                .offset(x: offsetX)
        }
    }
}
