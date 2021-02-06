//
//  MarkdownText.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI
import MarkdownUI

struct MarkdownText: View {
    
    let markdownString: String
    init(_ markdownString: String) {
        self.markdownString = markdownString
    }
    
    var body: some View {
        Markdown(Document(markdownString))
            .markdownStyle(MarkdownStyle(font: .system(size: 14.0)))
    }
}

struct MarkdownText_Previews: PreviewProvider {
    static let markdownText = "# Rules\n1. No bigotry - including racism, sexism, ableism, homophobia, or xenophobia. [Code of Conduct](https://github.com/dessalines/lemmy/blob/master/CODE_OF_CONDUCT.md).\n1. Be respectful. Everyone should feel welcome here.\n1. No porn.\n1. No Ads / Spamming.\n\n\nFeel free to ask questions over in:\n- [!lemmy_support](https://dev.lemmy.ml/c/lemmy_support)\n- [Matrix Chat](https://matrix.to/#/#lemmy:matrix.org)\n- [Mastodon @LemmyDev](https://mastodon.social/@LemmyDev)"
    
    static var previews: some View {
        Group {
            MarkdownText(markdownText).preferredColorScheme(.light)
            MarkdownText(markdownText).preferredColorScheme(.dark)
        }
    }
}
