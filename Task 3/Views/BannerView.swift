import SwiftUI
struct BannerView: View {
    @State private var currentPage = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("Image5")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 85)
                .clipped()
                .padding()
            Spacer()
            TabView(selection: $currentPage) {
                ForEach(1..<5, id: \.self) { index in
                    Image("Image_\(index)")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 400)
            .padding()
            .onReceive(timer) { _ in
                withAnimation {
                    currentPage = (currentPage + 1) % 5
                }
            }
            .gesture(DragGesture().onEnded({ (value) in
                if value.translation.width < 0 {
                    withAnimation {
                        currentPage = min(currentPage + 1, 4)
                    }
                } else if value.translation.width > 0 {
                    withAnimation {
                        currentPage = max(currentPage - 1, 0)
                    }
                }
            }))
        }
        .padding(.leading, 20)
    }
}
#Preview {
    BannerView()
}
