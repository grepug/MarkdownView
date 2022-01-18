//
//  File.swift
//  
//
//  Created by Kai on 2022/1/18.
//

import SwiftUI
import Prettier

public struct MarkdownEditorWindow: View {
    @Binding var markdownString: String

    @State private var showingPreview = false
    
    private static let prettier = PrettierFormatter(language: .markdown)
    private static var prettierPrepared = false
    
    public init(markdownString: Binding<String>) {
        self._markdownString = markdownString
        
        if !Self.prettierPrepared {
            Self.prettier.prepare()
            Self.prettierPrepared = true
        }
    }
    
    public var body: some View {
        MarkdownEditor(source: $markdownString)
            .toolbar {
                ToolbarButton(systemImageName: "paintbrush") {
                    let res = Self.prettier.format(markdownString)
                    
                    switch res {
                    case .success(let string): markdownString = string
                    case .failure(let err): print(err)
                    }
                }
                
                ToolbarButton(systemImageName: "eye",
                              color: showingPreview ? .accentColor : nil,
                              action: {
                    showingPreview.toggle()
                })
                    .popover(isPresented: $showingPreview) {
                        MarkdownPreview(markdownString)
                            .frame(width: 500, height: 800)
                    }
            }
    }
    
}

struct ToolbarButton: View {
    var systemImageName: String
    var color: Color?
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemImageName)
                .foregroundColor(color)
        }
        .onNewSystem { button in
            if #available(macOS 12.0, iOS 15.0, *) {
                button
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

extension View {
    @ViewBuilder func onNewSystem<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View {
        if #available(iOS 15.0, macOS 12.0, *) {
            transform(self)
        } else {
            self
        }
    }
}
