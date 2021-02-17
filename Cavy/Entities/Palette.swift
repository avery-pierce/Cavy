//
//  Palette.swift
//  Cavy
//
//  Created by Avery Pierce on 2/17/21.
//

import Foundation
import SwiftUI

protocol Palette {
    var red: Color { get }
    var orange: Color { get }
    var yellow: Color { get }
    var green: Color { get }
    var blue: Color { get }
    var purple: Color { get }
    
    var upvote: Color { get }
    var downvote: Color { get }
    
    var opCommentUsername: Color { get }
    var adminUsername: Color { get }
    var communityName: Color { get }
    var postSubmitterUsername: Color { get }
}

protocol LemmyTheme: Palette {
    var blue: Color { get }
    var indigo: Color { get }
    var purple: Color { get }
    var pink: Color { get }
    var red: Color { get }
    var orange: Color { get }
    var yellow: Color { get }
    var green: Color { get }
    var teal: Color { get }
    var cyan: Color { get }
    var white: Color { get }
    var gray: Color { get }
    var grayDark: Color { get }
    
    var primary: Color { get }
    var secondary: Color { get }
    var success: Color { get }
    var info: Color { get }
    var warning: Color { get }
    var danger: Color { get }
    var light: Color { get }
    var dark: Color { get }
}

extension LemmyTheme {
    var upvote: Color { info }
    var downvote: Color { danger }
    var communityName: Color { primary }
    var postSubmitterUsername: Color { info }
    var adminUsername: Color { indigo }
    var opCommentUsername: Color { info }
}

struct LemmyLightTheme: LemmyTheme {
    let blue = Color(hex: "#007bff")
    let indigo = Color(hex: "#6610f2")
    let purple = Color(hex: "#6f42c1")
    let pink = Color(hex: "#e83e8c")
    let red = Color(hex: "#d8486a")
    let orange = Color(hex: "#f1641e")
    let yellow = Color(hex: "#ffc107")
    let green = Color(hex: "#00C853")
    let teal = Color(hex: "#20c997")
    let cyan = Color(hex: "#02bdc2")
    let white = Color(hex: "#ffffff")
    let gray = Color(hex: "#6c757d")
    let grayDark = Color(hex: "#343a40")
    
    let primary = Color(hex: "#f1641e")
    let secondary = Color(hex: "#00C853")
    let success = Color(hex: "#6610f2")
    let info = Color(hex: "#007bff")
    let warning = Color(hex: "#ffc107")
    let danger = Color(hex: "#873208")
    let light = Color(hex: "#f8f9fa")
    let dark = Color(hex: "#343a40")
}

struct LemmyDarkTheme: LemmyTheme {
    let blue = Color(hex: "#375a7f")
    let indigo = Color(hex: "#6610f2")
    let purple = Color(hex: "#6f42c1")
    let pink = Color(hex: "#e83e8c")
    let red = Color(hex: "#e74c3c")
    let orange = Color(hex: "#fd7e14")
    let yellow = Color(hex: "#f39c12")
    let green = Color(hex: "#00bc8c")
    let teal = Color(hex: "#20c997")
    let cyan = Color(hex: "#3498db")
    let white = Color(hex: "#fff")
    let gray = Color(hex: "#888")
    let grayDark = Color(hex: "#303030")
    
    let primary = Color(hex: "#375a7f")
    let secondary = Color(hex: "#444")
    let success = Color(hex: "#00bc8c")
    let info = Color(hex: "#3498db")
    let warning = Color(hex: "#f39c12")
    let danger = Color(hex: "#e74c3c")
    let light = Color(hex: "#303030")
    let dark = Color(hex: "#dee2e6")
    
    var communityName: Color { green }
    var adminUsername: Color { red }
}

