import SwiftUI
import CodeEditor

public struct MarkdownEditor: View {
    @Binding var source: String
    
    public init(source: Binding<String>) {
        self._source = source
    }
    
    public var body: some View {
        CodeEditor(source: $source, language: .markdown, theme: .agate)
    }
}
