# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

    Yes, the following properties are not autoreleased - punctuationSet, wordFrequency, wordFrequency[word] (in else statement)

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

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }
    
    [punctuationSet release];

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
            Autoreleased - convenience init
    
    
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
            Need to release - "retain"
    
    
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
            Need to release - "alloc"
    
    
	4. `NSDate *food = [NSDate new];`
            Need to release - "new"
    
    
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
            Need to release - "alloc"
    
    
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
            Autoreleased - "autorelease"


3. Explain when you need to use the `NSAutoreleasePool`.

    Autorelease pools are used for methods that quickly create a large number of objects that use a lot of memory, in situations where those objects are used briefly and then no longer needed. This prevents the app from unnecessarily using too much memory at once, therefore improving performance and preventing crashes.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)person;
+ (instancetype)personWithName:(NSString *)name;

@end
```

```swift
@implementation LSIPerson

+ (instancetype)person
{
    return [self personWithName:nil];
}

+ (instancetype)personWithName:(NSString *)name
{
    Person *person = [[self alloc] initWithName:name];
    return [person autorelease];
}

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name.copy;
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

@end
```
