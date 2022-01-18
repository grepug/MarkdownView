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
    var maxedHeight: Bool
    var labelString: String
    var offsetX: CGFloat
    var onOpenEditor: (() -> Void)?
    
    @Environment(\.colorScheme) private var colorScheme
    
    var backgroundColor: Color {
        colorScheme == .light ? .white : .clear
    }
    
    public init(_ labelString: String,
                text: Binding<String>,
                height: CGFloat = 200,
                maxedHeight: Bool = false,
                offsetX: CGFloat = -35,
                openEditor: (() -> Void)? = nil) {
        self.labelString = labelString
        _text = text
        self.height = height
        self.maxedHeight = maxedHeight
        self.offsetX = offsetX
        self.onOpenEditor = openEditor
    }
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            ZStack(alignment: .topLeading) {
                VStack {
                    MarkdownEditor(source: $text)
                        .frame(height: maxedHeight ? nil : height)
                        .frame(maxWidth: .infinity, maxHeight: maxedHeight ? .infinity : nil)
                }
                .border(Color.gray.opacity(0.3))
                
                Text(labelString)
                    .offset(x: offsetX)
            }
                
            ButtonForOpenningMarkdownEditor {
                onOpenEditor?()
            }
        }
    }
}

public struct ButtonForOpenningMarkdownEditor: View {
    var action: (() -> Void)?
    
    public init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: "arrow.up.left.and.arrow.down.right")
        }
        .buttonStyle(.plain)
    }
}
