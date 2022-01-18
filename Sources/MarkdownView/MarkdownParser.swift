//
//  File.swift
//  
//
//  Created by Kai on 2022/1/17.
//

import Ink

struct Parser {
    var parser: MarkdownParser
    
    init() {
        var parser = MarkdownParser()
        
        parser.addModifier(.init(target: .headings, closure: { html, markdown in
            html + """
            <style>body { font-family: -apple-system, "system-ui", "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji"; font-size: 13px; padding: 8px; color: #333; }</style>
            """
        }))
        
        self.parser = parser
    }
    
    func htmlString(fromMarkdown markdown: String) -> String {
        parser.html(from: markdown)
    }
}
