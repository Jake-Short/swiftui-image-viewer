import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: Binding<String>
    private var cancellable: AnyCancellable?
    
    func getURLRequest(url: String) -> URLRequest {
        let url = URL(string: url) ?? URL(string: "https://via.placeholder.com/150.png")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request;
    }
    
    init(url: Binding<String>) {
        self.url = url
        
        if(url.wrappedValue.count > 0) {
            load()
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: getURLRequest(url: self.url.wrappedValue))
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
