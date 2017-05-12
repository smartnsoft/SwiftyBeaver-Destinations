<h3 align="center">
    <img src="logo.png" width="300" />
</h3>

# SwiftyBeaver-Destinations

[![CI Status](http://img.shields.io/travis/smartnsoft/SwiftyBeaver-Destinations.svg?style=flat)](https://travis-ci.org/smartnsoft/SwiftyBeaver-Destinations)
[![Version](https://img.shields.io/cocoapods/v/SwiftyBeaver-Destinations.svg?style=flat)](http://cocoapods.org/pods/SwiftyBeaver-Destinations)
[![License](https://img.shields.io/cocoapods/l/SwiftyBeaver-Destinations.svg?style=flat)](http://cocoapods.org/pods/SwiftyBeaver-Destinations)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyBeaver-Destinations.svg?style=flat)](http://cocoapods.org/pods/SwiftyBeaver-Destinations)

Add pre-configured console destinations for and based on [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver).

Available destinations:

- [LogEntries](https://logentries.com/)
- [Logmatic](https://logmatic.io)

## Requirements 

- iOS 9
- Xcode 8.3.2+

## Installation

SwiftyBeaver-Destinations is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile with your desired destination:

```ruby
pod "SwiftyBeaver-Destinations/LogEntries"
pod "SwiftyBeaver-Destinations/Logmatic"
```

If you just want utils :

`pod "SwiftyBeaver-Destinations/Core"` (SwiftyBeaver + Utils)


## Example

To run the example project, clone the repo, and run `pod install` from the `Example` directory first.

## Usage

In your AppDelegate class, add `let log = SwiftyBeaver.self`

### Add a destination

Configure SwiftyBeaver by adding your destinations: `log.addDestination(<YourDestination>)`

Available destinations at the moment are:

- `LogEntriesDestination(token: String, level: SwiftyBeaver.Level)`
- `Logmatic(apiKey: String, level: SwiftyBeaver.Level)`


### Utils

**`LogUtils` file contains methods for logs:**

- device details's dictionary (OS version, host name, device name and model): `deviceDetails() -> [String: String]`
- thread name if you aren't on the main thread: `threadName() -> String`

**`Destinations` file contains methods for SwiftyBeaver:**

*SwiftyBeaver's extensions*:

- remove a destination: `log.removeDestination(_ dest: BaseDestination.Type)`

*Default destinations*:

- Default console with emojis 🎉: `log.addDestination(Destinations.console)`

## Author

The iOS Team @Smart&Soft, software agency [http://www.smartnsoft.com](http://www.smartnsoft.com)

## License

SwiftyBeaver-Destinations is available under the MIT license. See the LICENSE file for more info.
