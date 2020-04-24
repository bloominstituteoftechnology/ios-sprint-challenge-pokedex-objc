# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // LEAK

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // LEAK

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1]; 
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; LEAK
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    ```objc
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];
    
    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];
    
    for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count) {
    wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
    wordFrequency[word] = [NSNumber numberWithInt:1];
    }
    }
    
    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```
2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];`  // YES  Reason: no alloc/ init keyword
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` // NO   Reason: retain keyword
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` // NO Reason: alloc keyword
	
	4. `NSDate *food = [NSDate new];` // NO Reason: new keyword
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` // NO Reason: alloc keyword
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` // YES  Reason: autorelease keyword

3. Explain when you need to use the `NSAutoreleasePool`.
for (NSInteger i = 0; i < 100; ++i) {
ComplexObject *obj = [ComplexObject new];
[obj doLotsOfWork];
}
It doesn’t matter what ComplexObject is or what doLotsOfWork entails, other than it being a placeholder for “lots of objects are being created here.”

We don’t know when those objects will be destroyed. ARC might destroy some or all of them immediately using release, or it might queue some or all of them up for destruction using autorelease – that’s an implementation detail we don’t have much control over.

However, if autorelease is used, then that loop will run 100 times before the autoreleased objects are released. That could mean your app chewing up huge amounts of RAM, most of which is objects awaiting deallocation.

The solution to this is to use @autoreleasepool blocks.  Any code you place inside an @autoreleasepool block will automatically have its autoreleased objects destroyed when the block ends. So, we could rewrite our loop like this:”

for (NSInteger i = 0; i < 100; ++i) {
@autoreleasepool {
ComplexObject *obj = [ComplexObject new];
[obj doLotsOfWork];
}
}
That allocates and destroys the same amount of memory, but now the high water mark – the total amount of memory in use at any one time – is significantly lower, because we free autoreleased objects each time the loop goes around.”

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)personWithName: (NSString *)name;
@end
```
@implementation 
- (instancetpe)initWithName:(NSString *)name {
self = [super init];
if (self) {
_name = [name copy];
}
return self;
}

- (instancetype)personWithName: (NSString *)name {
return [[[LSIPerson alloc]initWithName: name] autorelease];
}
