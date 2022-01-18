//
//  File.swift
//  
//
//  Created by Kai on 2022/1/18.
//

import SwiftUI
import Prettier

public struct MarkdownEditorWindow: View {
    private static let prettier = PrettierFormatter(language: .markdown)
    private static var prettierPrepared = false
    
    @Binding var markdownString: String
    @Binding var formatFlag: Int

    @State private var showingPreview = false
    
    public init(markdownString: Binding<String>,
                formatFlag: Binding<Int>) {
        self._markdownString = markdownString
        self._formatFlag = formatFlag
        
        if !Self.prettierPrepared {
            Self.prettier.prepare()
            Self.prettierPrepared = true
        }
    }
    
    public var body: some View {
        MarkdownEditor(source: $markdownString)
            .onChange(of: formatFlag, perform: { newValue in
                format()
            })
            .toolbar {
                ToolbarButton(systemImageName: "paintbrush") {
                    format()
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
    
    private func format() {
        let res = Self.prettier.format(markdownString)
        
        switch res {
        case .success(let string): markdownString = string
        case .failure(let err): print(err)
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
