# SwiftyClicker


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```ruby
let swiftyClicker = SwiftyClicker()
if let browserView = swiftyClicker.getSwifytClickerView(frame: view.frame) {
  view.addSubview(browserView)
  swiftyClicker.setupSwiftyClicker(settings: SwiftyClickerSettings(type: .scroller)) // .clicker, .refresher
  swiftyClicker.load(url: "search text or url")
}
```
Start Scroller
```ruby
self.swiftyClicker.startScroller(px: 300) { err, response in

}
```
Start Refresher
```ruby
self.swiftyClicker.startRefresher { err, response in
                
}
```
Start Clicker
```ruby
self.swiftyClicker.updateMarks(numberOfMark: 1) // Marks count be in 1-5
self.swiftyClicker.startClicker { err, response in

}
```

## Installation

SwiftyClicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyClicker'
```

## Author

Alperen Polat GEZGIN, alperengezgin@gmail.com

## License

SwiftyClicker is available under the MIT license. See the LICENSE file for more info.
