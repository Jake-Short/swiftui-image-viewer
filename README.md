# SwiftUI Image Viewer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


## Summary

An image viewer built using SwiftUI. Featuring drag to dismiss, pinch to zoom, and more.

## Installation via Swift Package Manager

File > Swift Packages > Add Package Dependancy

```https://github.com/Jake-Short/swiftui-image-viewer.git```

## Usage

```Swift
import swiftui-image-viewer

struct ContentView: View {
	@State var showImageViewer: Bool = true
	
	var body: some View {
		VStack {
			Text("Example!")
		}
		.overlay(self.showImageViewer ?
		ImageViewer(image: Image("example-image"), viewerShown: self.$showImageViewer) : nil)
	}
}
```

## License

This project is licensed under the MIT license.
