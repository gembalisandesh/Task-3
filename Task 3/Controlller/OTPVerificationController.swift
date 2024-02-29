import Foundation

class OTPVerificationController: ObservableObject {
    func verifyOTP(data: OTPVerificationData, completion: @escaping (Bool) -> Void) {
        let defaultOTP = "123456"
        guard data.otp == defaultOTP else {
            completion(false)
            return
        }
        
        guard let url = URL(string: "http://docapi.brokersaathi.co.in/api/Account/VerifyOtp") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        let body: [String: Any] = [
            "mobileNo": data.phoneNumber,
            "otp": data.otp
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Failed to encode body")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
}

