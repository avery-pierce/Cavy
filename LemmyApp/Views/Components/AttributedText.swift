//
//  AttributedText.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI
import Down

struct AttributedText: UIViewRepresentable {
    let attributedString: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.attributedText = attributedString
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}

struct AttributedText_Previews: PreviewProvider {
    static let attributedText = try! Down(markdownString: "# Rules\n1. No bigotry - including racism, sexism, ableism, homophobia, or xenophobia. [Code of Conduct](https://github.com/dessalines/lemmy/blob/master/CODE_OF_CONDUCT.md).\n1. Be respectful. Everyone should feel welcome here.\n1. No porn.\n1. No Ads / Spamming.\n\n\nFeel free to ask questions over in:\n- [!lemmy_support](https://dev.lemmy.ml/c/lemmy_support)\n- [Matrix Chat](https://matrix.to/#/#lemmy:matrix.org)\n- [Mastodon @LemmyDev](https://mastodon.social/@LemmyDev)").toAttributedString()
    
    static var previews: some View {
        AttributedText(attributedString: attributedText)
    }
}
