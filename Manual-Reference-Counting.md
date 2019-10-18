# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
Yes, where <Memory Leak> is located.
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

<Memory Leak>
	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
<Memory Leak>
	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
<Memory Leak>
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
        <Memory Leak>
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];
    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];
    for (NSString *word in words) {
        NSNumber *count = [[wordFrequency[word] retain] autorelease];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }
    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	yes becuase [NSDate date] is autorelease by default
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	no becuase retain makes it lose autorelease
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	no because if you alloc init with anything it does not have autorelease by default
	4. `NSDate *food = [NSDate new];`
	no, becuase [NSDate new] does not have autorelease by default
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	no because if you alloc init with anything it does not have autorelease by default
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
yes because autoreleased was called on it
3. Explain when you need to use the `NSAutoreleasePool`.
if you have a loop with alot of memory, to optimize it NSAutoRelease pool is used to offload memory at the end of each individual loop.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

(LSIPerso *) LSIPerson;

@end

@implementation

(LSIPerson *)LSIPerson {
return [[[LSIPerson alloc] init] autorelease];
}
@end
```
