import SwiftUI
import CodeEditor

public struct MarkdownEditor: View {
    @Binding var source: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(source: Binding<String>) {
        self._source = source
    }
    
    public var body: some View {
        CodeEditor(source: $source,
                   language: .markdown,
                   theme: colorScheme == .dark ? .default : .atelierSavannaLight,
                   flags: .defaultEditorFlags)
    }
}
