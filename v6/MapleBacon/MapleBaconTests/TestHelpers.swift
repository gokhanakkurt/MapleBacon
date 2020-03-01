//
//  Copyright © 2020 Schnaub. All rights reserved.
//

import UIKit
import MapleBacon
import XCTest

enum MockResponse {
  case data(Data)
  case error
}

func dummyData() -> Data {
  let string = #function + #file
  return Data(string.utf8)
}

func setupMockResponse(_ response: MockResponse) {
  switch response {
  case .data(let data):
    MockURLProtocol.requestHandler = { request in
      return (HTTPURLResponse(), data)
    }
  case .error:
    MockURLProtocol.requestHandler = { request in
      let anyError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
      throw anyError
    }
  }
}

func makeImage() -> UIImage {
  let renderer = UIGraphicsImageRenderer(size: .init(width: 10, height: 10))
  return renderer.image { context in
    UIColor.black.setFill()
    context.fill(renderer.format.bounds)
  }
}

func makeImageData() -> Data {
  makeImage().pngData()!
}

extension XCTestCase {
  func wait(for interval: TimeInterval) {
      let date = Date(timeIntervalSinceNow: interval)
      RunLoop.current.run(mode: RunLoop.Mode.default, before: date)
  }
}

final class FirstDummyTransformer: ImageTransforming {

  let identifier = "com.schnaub.FirstDummyTransformer"

  var callCount = 0

  func transform(image: UIImage) -> UIImage? {
    callCount += 1
    return image
  }

}

final class SecondDummyTransformer: ImageTransforming {

  let identifier = "com.schnaub.SecondDummyTransformer"

  var callCount = 0

  func transform(image: UIImage) -> UIImage? {
    callCount += 1
    return image
  }

}

final class ThirdDummyTransformer: ImageTransforming {

  let identifier = "com.schnaub.ThirdDummyTransformer"

  var callCount = 0

  func transform(image: UIImage) -> UIImage? {
    callCount += 1
    return image
  }

}
