//
//  Themed.swift
//  Cavy
//
//  Created by Avery Pierce on 2/17/21.
//

import SwiftUI

struct Themed<Children: View>: View {
    @Environment(\.colorScheme) var colorScheme
    
    let children: Children
    init(@ViewBuilder _ childrenBuilder: () -> Children) {
        self.init(children: childrenBuilder())
    }
    
    init(children: Children) {
        self.children = children
    }
    
    init() where Children == EmptyView {
        self.children = EmptyView()
    }
    
    var currentPalette: Palette {
        switch colorScheme {
        case .light: return LemmyLightTheme()
        case .dark: return LemmyDarkTheme()
        default: return LemmyLightTheme()
        }
    }
    
    var body: some View {
        children.palette(currentPalette)
    }
}

struct Themed_Previews: PreviewProvider {
    static var previews: some View {
        Themed()
    }
}

private struct PaletteEnvironmentKey: EnvironmentKey {
    static let defaultValue: Palette = LemmyLightTheme()
}

extension EnvironmentValues {
    var palette: Palette {
        get { self[PaletteEnvironmentKey.self] }
        set { self[PaletteEnvironmentKey.self] = newValue }
    }
}

extension View {
    func palette(_ palette: Palette) -> some View {
        environment(\.palette, palette)
    }
}
