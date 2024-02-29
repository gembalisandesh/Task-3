import SwiftUI
import Combine

struct StartView: View {
    @State private var phoneNumber: String = ""
    @State private var isNextViewActive: Bool = false
    @StateObject private var otpController = OTPController()
    
    var body: some View {
        NavigationView {
            VStack {
                BannerView()
                    .padding(.bottom, 20)
                Spacer()
                Text("Enter your mobile number")
                    .font(.title)
                    .padding()
                
                TextField("Mobile number", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(height: 40)
                
                NavigationLink(destination: OTPVerificationView(phoneNumber: phoneNumber), isActive: $isNextViewActive) {
                    EmptyView()
                }
                
                Button(action: {
                    sendOTP()
                }) {
                    Text("Trouble Signing In")
                        .underline()
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }
            }
            .onReceive(Just(phoneNumber)) { value in
                if value.count == 10 {
                    sendOTP()
                }
            }
        }
    }
    
    private func sendOTP() {
        let data = OTPData(phoneNumber: phoneNumber)
        otpController.sendOTP(data: data) { success in
            DispatchQueue.main.async {
                isNextViewActive = success
            }
        }
    }
}
#Preview {
    StartView()
}
