The solution requires removing the observer before the observed object is deallocated.  This can be achieved by either removing the observer manually before deallocation, or by using a strong reference and managing the observer's lifetime carefully. A safer solution is to use blocks. 

```objectivec
@interface MyObject : NSObject
@property (nonatomic, weak) MyOtherObject *otherObject;
@end

@implementation MyObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == nil) return; //handle the case where object is deallocated
    // ... handle KVO notification ...
}
@end

@interface MyOtherObject : NSObject
@property (nonatomic, strong) NSString *someProperty;
@end

@implementation MyOtherObject
-(void)dealloc{
    [self removeObserver:myObject forKeyPath:@