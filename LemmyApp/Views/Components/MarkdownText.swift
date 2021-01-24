//
//  MarkdownText.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI
import Down

struct MarkdownText: View {
    @Environment(\.colorScheme) var colorScheme
    
    let markdownString: String
    init(_ markdownString: String) {
        self.markdownString = markdownString
    }
    
    let stylesheetLightTheme: String = """
    * {font-family: -apple-system; color: #000;}
    code, pre { font-family: Menlo }
    """
    
    let stylehseetDarkTheme: String = """
    * {font-family: -apple-system; color: #FFF;}
    code, pre { font-family: Menlo }
    """
    
    var stylesheet: String {
        switch colorScheme {
        case .dark: return stylehseetDarkTheme
        default: return stylesheetLightTheme
        }
    }
    
    var attributedString: NSAttributedString {
        if Thread.isMainThread {
            return try! Down(markdownString: markdownString).toAttributedString(stylesheet: nil)
        } else {
            return DispatchQueue.main.sync {
                return try! Down(markdownString: markdownString).toAttributedString(stylesheet: nil)
            }
        }
    }
    
    var htmlString: String {
        return try! Down(markdownString: markdownString).toHTML()
    }
    
    var body: some View {
        HTMLView(htmlContent: htmlString)
    }
}

struct MarkdownText_Previews: PreviewProvider {
    static let markdownText = "# Rules\n1. No bigotry - including racism, sexism, ableism, homophobia, or xenophobia. [Code of Conduct](https://github.com/dessalines/lemmy/blob/master/CODE_OF_CONDUCT.md).\n1. Be respectful. Everyone should feel welcome here.\n1. No porn.\n1. No Ads / Spamming.\n\n\nFeel free to ask questions over in:\n- [!lemmy_support](https://dev.lemmy.ml/c/lemmy_support)\n- [Matrix Chat](https://matrix.to/#/#lemmy:matrix.org)\n- [Mastodon @LemmyDev](https://mastodon.social/@LemmyDev)"
    
    static var previews: some View {
        Group {
            MarkdownText(markdownText)

        }
    }
}
