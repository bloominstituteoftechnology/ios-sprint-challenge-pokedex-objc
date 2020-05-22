# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

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

**Look for comments starting with MTG**

```swift
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

// MTG: Retain is not necessary. Everything is in the same scope.
NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count != nil) {
        wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
        // MTG: Because we are allocating the memory. We must release it. 
        // autorelease will allow it to happen automatically when wordFrequency gets dealloc.
        wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

// MTG: Because we are allocating the memory. We must release it. 
[wordFrequency release];
```
2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` **Autoreleased, we didn't create it **
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` **Not Autoreleased, we are taking ownership because of the retain **
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` **Not Autoreleased, it's our job to release if we alloc **
	
	4. `NSDate *food = [NSDate new];` **Not Autoreleased, we created it, we must release it **
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` **Not Autoreleased, we created it, we must release it **
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` **Autoreleased, we created it but we tagged it as autorelease **

3. Explain when you need to use the `NSAutoreleasePool`.

**When you spawn a thread, having that code block in an NSAutoreleasePool will allow the memory to dispose of the temporary objects created in the thread. **

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personWithName:(NSString *)name;

@end
```

```
@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

// Implement autoreleased class car method
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
