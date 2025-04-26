//
//  UserInfo.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/18/25.
//

import  Foundation
import SwiftUI

struct UserInfo {
    var username: String
    var email: String
    var zipCode: String
    var hometown: String
}


class UserData: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var zipCode: String = ""
    @Published var hometown: String = ""
    @Published var isRegistered: Bool = false
}
