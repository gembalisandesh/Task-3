import SwiftUI

class ProfileController: ObservableObject {
    @Published var profile: Profile

    init(profile: Profile) {
        self.profile = profile
    }

    func updateProfile() {
        guard let url = URL(string: "http://docapi.brokersaathi.co.in/api/User/UpdateUsersInfoForDoctor") else {
            print("Invalid URL")
            return
        }

        let body: [String: Any] = [
            "userId": profile.userId,
            "uName": profile.name,
            "imaNumber": profile.imaNumber,
            "experience": profile.experience,
            "completeAddress": profile.completeAddress,
            "emailId": profile.email,
            "passwords": profile.password,
            "age": Int(profile.age) ?? 0,
            "gender": profile.gender == "Male" ? 1 : (profile.gender == "Female" ? 2 : 3),
            "clinicName": profile.hospitalClinicName,
            "doctorAmount": 0
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Failed to encode body")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
        }.resume()
    }
}
