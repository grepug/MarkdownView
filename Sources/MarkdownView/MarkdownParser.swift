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
        let parser = MarkdownParser()
        
//        parser.addModifier(.init(target: .headings, closure: { html, markdown in
//
//        }))
        
        self.parser = parser
    }
    
    func htmlString(fromMarkdown markdown: String) -> String {
        parser.html(from: markdown)
    }
}
