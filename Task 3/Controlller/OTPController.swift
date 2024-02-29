import Foundation
class OTPController: ObservableObject {
    func sendOTP(data: OTPData, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://docapi.brokersaathi.co.in/api/Account/SendOtp") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        let body: [String: String] = ["mobileNo": data.phoneNumber]
        
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
