//
//  EncodeBase64.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import Foundation

extension String {
    func encodeToBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
