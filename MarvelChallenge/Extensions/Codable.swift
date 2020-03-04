//
//  Codable.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

extension Decodable {
     init?(from: [String: Any]) {
           do {
               let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
               let decoder = JSONDecoder()
               self = try decoder.decode(Self.self, from: data)
           } catch {
               return nil
           }
       }
}
