# Manual Reference Counting

My Answers (There are 2 different questions marked as #2 above):

1. Yes there are leaks with this code. They are found in the following lines where release is never called:
```swift
NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; <-- retains with alloc and init, but never releases
wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
```

2. Rewrite of the code so it doesn't leak memory is below:
```swift
NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];
wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
```

2. Which ones are autoreleased and why?
`NSDate *yesterday = [NSDate date];`
autoreleased because it is initialized with a `convenience init`.
`NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
not autoreleased because it calls the `retain` method on the object as soon as it's initialized.
`NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
not autoreleased because it is initialized using `alloc` and a designated `init` initializer.
`NSDate *food = [NSDate new];` 
not autoreleased because it is initialized using `new`.
`LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
not autoreleased because it is initialized using `alloc` and a designated `init`.
`LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
autoreleased because it calls the `autorelease` method on the object as soon as it is initialized.

3. When should you use an autorelease pool:
You don't have to. Unless:
a. you are writing a loop that creates many temporary objects -> dispose of the objects before the next iteration.
b. if you spawn a secondary thread -> create autorelease pool block as soon as thread begins executing.
c. you are writing a command-line tool or other program not based on a UI framework.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object:
```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personWithName:(NSString *)name;

@end

@implementation LSIPerson

+ (instancetype)personWithName:(NSString *)name {
LSIPerson *person = [[self alloc] initWithName:name];
return [person autorelease]; <-- here
}

@end
```
