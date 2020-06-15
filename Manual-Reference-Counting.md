# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

/*===================LEAK==================*/

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];  
`retain` is being used, puncuationSet needs to be released

/*===================END===================*/

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

/*===================LEAK==================*/

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; 
Also needs to be released.

/*===================END===================*/

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
        
/*===================LEAK==================*/

			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
Using `alloc` to initialize so this also needs to be released
            
/*===================END===================*/
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

2. Rewrite the code so that it does not leak any memory with ARC disabled

    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] autorelease];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] auotrelease];
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    Autoreleased because it's not using alloc, init, retain
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    Needs to be released because retain is being called
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    Needs to be released because of `alloc init`
	
	4. `NSDate *food = [NSDate new];`
    Needs to be released because of `new`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    Needs to be released because of `alloc`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    Autoreleased because `autorelease` is called

3. Explain when you need to use the `NSAutoreleasePool`.
When looping through large amounts of data to free up memory while inside the loop

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.


```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name 
{

    if (self = [super init]) {
        _name = [name copy];
    }
    return self;
}

+ (instancetype)initPersonWithName:(NSString *)name 
{
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
