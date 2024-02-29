import Foundation
import SwiftUI

struct Profile {
    var userId: Int
    var name: String
    var age: String
    var gender: String
    var imaNumber: String
    var hospitalClinicName: String
    var experience: String
    var completeAddress: String
    var email: String
    var password: String
    var confirmPassword: String
    var profileImage: Image?
    var profileImageUrl: String

    init(userId: Int = 0,
         name: String = "",
         age: String = "",
         gender: String = "",
         imaNumber: String = "",
         hospitalClinicName: String = "",
         experience: String = "",
         completeAddress: String = "",
         email: String = "",
         password: String = "",
         confirmPassword: String = "",
         profileImage: Image? = nil,
         profileImageUrl: String = "") {
        
        self.userId = userId
        self.name = name
        self.age = age
        self.gender = gender
        self.imaNumber = imaNumber
        self.hospitalClinicName = hospitalClinicName
        self.experience = experience
        self.completeAddress = completeAddress
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.profileImage = profileImage
        self.profileImageUrl = profileImageUrl
    }
}
