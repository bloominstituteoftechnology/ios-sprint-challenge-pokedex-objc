# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];  // There's a leak here, no release.

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // There is no realse method


	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
        wordFrequency[word] = [[NSNumber alloc] initWithInteger:1] autorelease];//Theres a leak, no realse method. auto release added
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    [wordFrequency release];
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` // Autorelease because its not implemented
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` // Not autoreleased because we are taking owner ship by "retain"
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	//Not autorelease because we are allocating 
	4. `NSDate *food = [NSDate new];`
	// Auto release becayse it isnt implemented
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	// Not autoRelease because were allocating it
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
            // Auto release because we have createe it and set to auto releas4
3. Explain when you need to use the `NSAutoreleasePool`.
//NSAutoreleasePool works as a garbage collection, when releasing a thread, it holds the lifetime of an object memory by giving it commands like autorelease, release, alloc, dealloc, retain.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personWithName:(NSString *)name;

@implementation LSIPerson
- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}
// Implement autoreleased class method
+ (instancetype)personWithName:(NSString *)name {
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}
// This is only necessary if ARC is turned off.
- (void)dealloc
{
    [_name release];
    [super dealloc];
}
@end
```
