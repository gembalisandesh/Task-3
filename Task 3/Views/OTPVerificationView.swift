import SwiftUI

struct OTPVerificationView: View {
    let phoneNumber: String
    @State private var otp: String = ""
    @State private var showIncorrectOTPMesssage: Bool = false
    @State private var isNavigationActive: Bool = false
    @StateObject private var otpVerificationController = OTPVerificationController()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter the 6-digit OTP sent to \(phoneNumber)")
                .font(.title)
                .padding()
            
            TextField("OTP", text: $otp)
                .keyboardType(.numberPad)
                .padding()
                .frame(height: 40)
            
            if showIncorrectOTPMesssage {
                Text("Please enter valid OTP")
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            Button(action: {
                verifyOTP()
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            NavigationLink(
                destination: ProfileScreen(),
                isActive: $isNavigationActive,
                label: { EmptyView() }
            )
            .hidden()
            
            Spacer()
        }
    }
    
    private func verifyOTP() {
        let data = OTPVerificationData(phoneNumber: phoneNumber, otp: otp)
        otpVerificationController.verifyOTP(data: data) { success in
            DispatchQueue.main.async {
                if success {
                    isNavigationActive = true
                } else {
                    showIncorrectOTPMesssage = true
                }
            }
        }
    }
}
#Preview {
    OTPVerificationView(phoneNumber: "122222222")
}
