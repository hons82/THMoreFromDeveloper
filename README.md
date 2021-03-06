THMoreFromDeveloper
===

[![Pod Version](http://img.shields.io/cocoapods/v/THMoreFromDeveloper.svg?style=flat)](http://cocoadocs.org/docsets/THMoreFromDeveloper/)
[![Pod Platform](http://img.shields.io/cocoapods/p/THMoreFromDeveloper.svg?style=flat)](http://cocoadocs.org/docsets/THMoreFromDeveloper/)
[![Pod License](http://img.shields.io/cocoapods/l/THMoreFromDeveloper.svg?style=flat)](http://opensource.org/licenses/MIT)

This control can be used to show other Apps from a developer or a list of APPs that can be intresting to the user of a current APP.

# Screenshots

![iPhone Portrait](/Screenshots/Screenshot1.png?raw=true)
![iPhone Landscape](/Screenshots/Screenshot2.png?raw=true)

# Installation

### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

``` ruby
platform :ios, '6.1'
pod 'THMoreFromDeveloper', '~> 0.1.1'
```

**Note**: We follow http://semver.org for versioning the public API.

### Manually

Or copy the `THMoreFromDeveloper/` directory from this repo into your project and add the following dependencies

# Dependencies

- [THCache](https://github.com/hons82/THCache)
- [SDWebImage](https://github.com/rs/SDWebImage)
- [Reachability](https://github.com/tonymillion/Reachability)

# Features

### V0.1.X

- Bugfix/Help [#1](https://github.com/hons82/THMoreFromDeveloper/issues/1)

### V0.0.X

- Bugfix
- Load single AppId [http://itunes.apple.com/lookup?id=833472031&lang=en&country=US](http://itunes.apple.com/lookup?id=833472031&lang=en&country=US) 
- Load a List of AppIds
- Load all Apps from a Developer[http://itunes.apple.com/lookup?id=833472034&lang=en&country=US&entity=software](http://itunes.apple.com/lookup?id=833472034&lang=en&country=US&entity=software)
- Results are cached and reused based on [Reachability](https://github.com/tonymillion/Reachability)

# Usage

``` objective-c
#import "THMoreFromDeveloperModel.h"

@interface THMoreFromDeveloperCollectionViewController ()
@property (nonatomic,strong)THMoreFromDeveloperModel *model;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[THMoreFromDeveloperModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appIdsLoaded:)
                                                 name:kMoreFromDeleveloperDone
                                               object: nil];
	// Load it with APPids
	[self.model loadAppIds:@[@"509943167",@"875251011",@"420636551",@"645859810",@"767319014"]];
	// Load it with a single Developer ID
	// [self.model loadDeveloperId:@"833472034"];
}

- (void)appIdsLoaded:(NSNotification* )notification {
    // Show data using [self.model jsonResults]
}
```

for more details please have a look at the Example. It shows how to integrate this classes with the rest of your project.

#Contributions

...are really welcome. If you have an idea just fork the library change it and if its useful for others and not affecting the functionality of the library for other users I'll insert it

# License

Source code of this project is available under the standard MIT license. Please see [the license file](LICENSE.md).


