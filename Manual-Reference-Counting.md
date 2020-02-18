# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
	* yes - `punctuationSet` and `wordFrequency` are not released at the end of the function. Additionally, when `count` is nil, the NSNumber is owned by self, but never released.


	```objectivec
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
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
	```


	2. Rewrite the code so that it does not leak any memory with ARC disabled
		
		```objectivec
		NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

		NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

		NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
		NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

		NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

		for (NSString *word in words) {
			NSNumber *count = wordFrequency[word];
			if (count != nil) {
				wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
			} else {
				NSNumber *number = [[NSNumber alloc] initWithInteger:1];
				wordFrequency[word] = number;
				[number release];
			}
		}

		printf("Word frequency: %s", wordFrequency.description.UTF8String);

		[punctuationSet release];
		[wordFrequency release];
		```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
		* auto - cuz convenience init
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
		* manual - cuz retain
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
		* manual - cuz normal init
	
	4. `NSDate *food = [NSDate new];`
		* manual - cuz normal new
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
		* manual - cuz normal init
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
		* auto - cuz literally says


3. Explain when you need to use the `NSAutoreleasePool`.
	* loops when there's a large amount of data


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```objectivec
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

+ (LSIPerson)personWithName:(NSString *)name {
	return [[[LSIPerson alloc] initWithName: name] autorelease];
}

```
