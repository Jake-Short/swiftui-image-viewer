# SwiftUI Image Viewer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


## Summary

An image viewer built using SwiftUI. Featuring drag to dismiss, pinch to zoom, remote and local images, and more.

![image](https://media2.giphy.com/media/LSKUWsW9KogOLIS2ZS/giphy.gif?cid=4d1e4f29cacda6de9a149bb9b7a2717faec03a9ebd6d5fdd&rid=giphy.gif)

## Installation via Swift Package Manager

File > Swift Packages > Add Package Dependancy

```https://github.com/Jake-Short/swiftui-image-viewer.git```

## Usage

Local Image:
```Swift
import ImageViewer

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
        .overlay(ImageViewer(image: Image("example-image"), viewerShown: self.$showImageViewer))
    }
}
```

Remote Image:
```Swift
import ImageViewerRemote

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
        .overlay(ImageViewerRemote(imageURL: URL(string: "https://..."), viewerShown: self.$showImageViewer))
    }
}
```

## License

This project is licensed under the MIT license.
