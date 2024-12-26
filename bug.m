In Objective-C, a tricky bug can arise from the interaction between KVO (Key-Value Observing) and weak references.  Consider this scenario:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, weak) MyOtherObject *otherObject;
@end

@implementation MyObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... handle KVO notification ...
}
@end

@interface MyOtherObject : NSObject
@property (nonatomic, strong) NSString *someProperty;
@end

@implementation MyOtherObject
@end

// ... in some other class ...
MyObject *myObject = [[MyObject alloc] init];
MyOtherObject *otherObject = [[MyOtherObject alloc] init];
myObject.otherObject = otherObject;
[otherObject addObserver:myObject forKeyPath:@"someProperty" options:NSKeyValueObservingOptionNew context:NULL];

// ... later, if otherObject is deallocated ...
// ... the KVO notification will still be sent to myObject but otherObject will be nil
// ... causing a crash when accessing otherObject.
```