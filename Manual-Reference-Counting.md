# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // leak here, no release.

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // here there is no release method for this one.

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease]; // Leak! no release method for this one, auto release should be added.
		}
	}


	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	[wordFrequency release];

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` #Auto release, because we haven't implemented it.

	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	#NotAutoRelease, we are taking the ownership by retain.

	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	#NotAutoRelease - Because we are allocating it in the memory but we are not releasing.
	4. `NSDate *food = [NSDate new];`
	#AutoRelease - Because we haven't implemented one.

	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	#NotAutoRelease - Because we are allocating it in the memory but we are not releasing.

	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
#AutoRelease - Because we have created it and set to autorelease.
3. Explain when you need to use the `NSAutoreleasePool`.
#NSAutoreleasePool works as a garbage collection, when releasing a thread, it holds the lifetime of an object memory by giving it commands like autorelease, release, alloc, dealloc, retain.

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
