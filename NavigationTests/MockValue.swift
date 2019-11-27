//
//  MockValue.swift
//  NavigationTests
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation
import protocol Navigation.NavigationPath

enum MockValueCodingKeys: String, CodingKey {
    case name
    case value
}

indirect enum MockValue: NavigationPath, Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MockValueCodingKeys.self)
        switch try container.decode(String.self, forKey: .name) {
        case Login().path: self = .login(try container.decode(Login.self, forKey: .value))
        case Search().path: self = .search(try container.decode(Search.self, forKey: .value))
        case Area().path: self = .area(try container.decode(Area.self, forKey: .value))
        case Department().path: self = .department(try container.decode(Department.self, forKey: .value))
        case Level().path: self = .level(try container.decode(Level.self, forKey: .value))
        case Settings().path: self = .settings(try container.decode(Settings.self, forKey: .value))
        default: self = .none
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MockValueCodingKeys.self)
        switch self {
        case .login(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        case .search(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        case .area(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        case .department(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        case .level(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        case .settings(let value):
            try container.encode(value.path, forKey: .name)
            try container.encode(value, forKey: .value)
        default:
            try container.encode("None", forKey: .name)
        }
    }

    struct Login: NavigationPath, Codable {
        var username: String = ""
        var password: String = ""

        var path: String {
            "Login"
        }
    }

    struct Search: NavigationPath, Codable {
        var term: String = ""
        var results: [Area] = []

        var path: String {
            "Search"
        }
    }

    struct Area: NavigationPath, Codable {
        var country: String = ""
        var city: String = ""
        var departments: [Department] = []

        var path: String {
            "Area"
        }
    }

    struct Department: NavigationPath, Codable {
        var name: String = ""
        var levels: [Level] = []

        var path: String {
            "Department"
        }
    }

    struct Level: NavigationPath, Codable {
        var name: String = ""

        var path: String {
            "Level"
        }
    }

    struct Settings: NavigationPath, Codable {
        var isLoggedIn: Bool = false

        var path: String {
            "Settings"
        }
    }

    case none
    case login(Login)
    case search(Search)
    case area(Area)
    case department(Department)
    case level(Level)
    case settings(Settings)

    var path: String {
        switch self {
        case .area(let value as NavigationPath),
             .login(let value as NavigationPath),
             .search(let value as NavigationPath),
             .department(let value as NavigationPath),
             .level(let value as NavigationPath),
             .settings(let value as NavigationPath):
            return value.path
        case .none:
            return "None"
        }
    }
}
