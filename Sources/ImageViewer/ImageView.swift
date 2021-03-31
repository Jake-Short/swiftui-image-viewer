import SwiftUI

public struct ImageView: View {
    
    var imageDetails: ImageDetails
    @Binding var viewerShown: Bool
    
    @State var dragOffset: CGSize = .zero
    @State var dragOffsetPredicted: CGSize = .zero
    
    public init(imageDetails: ImageDetails, viewerShown: Binding<Bool>) {
        self.imageDetails = imageDetails
        _viewerShown = viewerShown
    }
    
    public var body: some View {
        VStack {
            ZStack {
                (imageDetails.image ?? Image(systemName: "questionmark.diamond"))
                    .resizable()
                    .aspectRatio(imageDetails.aspectRatio, contentMode: .fit)
                    .offset(x: self.dragOffset.width, y: self.dragOffset.height)
                    .rotationEffect(.init(degrees: Double(self.dragOffset.width / 30)))
                    .pinchToZoom()
                    .gesture(DragGesture()
                                .onChanged { value in
                                    self.dragOffset = value.translation
                                    self.dragOffsetPredicted = value.predictedEndTranslation
                                }
                                .onEnded { value in
                                    if((abs(self.dragOffset.height) + abs(self.dragOffset.width) > 570) || ((abs(self.dragOffsetPredicted.height)) / (abs(self.dragOffset.height)) > 3) || ((abs(self.dragOffsetPredicted.width)) / (abs(self.dragOffset.width))) > 3) {
                                        withAnimation(.spring()) {
                                            self.dragOffset = self.dragOffsetPredicted
                                        }
                                        self.viewerShown = false
                                        
                                        return
                                    }
                                    withAnimation(.interactiveSpring()) {
                                        self.dragOffset = .zero
                                    }
                                }
                    )
                
                if let caption = imageDetails.caption {
                    VStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Text(caption)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.12, green: 0.12, blue: 0.12, opacity: (1.0 - Double(abs(self.dragOffset.width) + abs(self.dragOffset.height)) / 1000)).edgesIgnoringSafeArea(.all))
        .zIndex(1)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    static var details = ImageDetails(image: Image(systemName: "gear"), caption: "Gear")
    
    static var previews: some View {
        ImageView(imageDetails: details, viewerShown: .constant(true))
    }
}
