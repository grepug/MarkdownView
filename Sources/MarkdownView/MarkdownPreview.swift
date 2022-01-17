//
//  File.swift
//  
//
//  Created by Kai on 2022/1/17.
//

import SwiftUI

public struct MarkdownPreview: View {
    var markdownString: String
    
    public init(_ markdownString: String) {
        self.markdownString = markdownString
    }
    
    var parsed: String {
        Parser().htmlString(fromMarkdown: markdownString)
    }
    
    public var body: some View {
        WebView(html: parsed)
    }
}
