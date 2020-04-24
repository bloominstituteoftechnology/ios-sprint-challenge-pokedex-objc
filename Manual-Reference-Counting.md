# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	Yes there are leaks.
	- punctuationSet doesn't need retain to be called
	- wordFrequency isn't released. Need to add an autorelease. 
	- initWithInteger: 1 needs an autorelease

	```swift
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
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count != nil) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	[wordFrequency release];
	```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	
	// YES. This is autoreleased. "*yesterday* doesn't own this.  
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];
	
	// NO. This isn't autoreleased. It has a "retain" at the end`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	// NO. This isn't autoreleased. We own this because of the alloc initWithString 
	
	4. `NSDate *food = [NSDate new];`
	
	// NO. This isn't autoreleased. There is "new" after NSDate
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	// NO. This isn't autoreleased. We own this because of the alloc initWithName
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
	
	// YES. This is autoreleased. We have an "autorelease" at the end. 

3. Explain when you need to use the `NSAutoreleasePool`.
- We need to use NSAutoreleasePool when we are using for loops that will create a giant amount of objects, which in turn can end up using a lot more memory than is allowed in the app. 

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```

Step 4 answer. 
```swift
+ (instanceType)personWithName:(NSString *)name { 
	return [[[self alloc]initWithName:name] autorelease];
}
```
