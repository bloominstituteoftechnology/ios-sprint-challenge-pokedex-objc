# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

Yes, punctuationSet is never released and wordFrequency is also allocated and initialized but not released. 

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
     [punctuationSet release];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
      [wordFrequency release];
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` Autoreleased, not the responsible party
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` Need to release, we explicitly said to retain
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` Need to release, we alloc and init the object
	
	4. `NSDate *food = [NSDate new];` Need to release, new also makes us the responsible party.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` Need to release, we alloc and init the object.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` Autoreleased, marked as such

3. Explain when you need to use the `NSAutoreleasePool`.

One scenario is when you're creating objects inside of a loop, you would use the pool to "drain" those objects prior to the next loop in order to reduce memory usage. Another scenario is if you are using multiple threads, if you have a lot of autoreleased objects, your memory usage is going to contuine growing as the thread continues being used unless you "drain" them. 

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)personWithName:(NSString *)name;

@end

@implementation

+ (instancetype)personWithName:(NSString *)name
{
    Person *person = [[self alloc] initWithName:name];
    return [person autorelease];
}

@end
```
