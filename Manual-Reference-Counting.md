# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

    ```objc
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // LEAK!

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // LEAK!

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // LEAK!
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

3. Which of these objects is autoreleased?  Why?
    1. `NSDate *yesterday = [NSDate date];` // autoreleased; not init/copy/retain; convenience initializer autoreleases
    2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` // NOT released; 'retain' gives us explicit ownership/responsibility
    3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` // NOT released; 'alloc/init' gives us explicit ownership/responsibility
    4. `NSDate *food = [NSDate new];` // autoreleased; not init/copy/retain; convenience initializer autoreleases
    5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` // NOT released; 'alloc/init' gives us explicit ownership/responsibility
    6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` // autoreleased due to keyword autorelease
4. Explain when you need to use the `NSAutoreleasePool`. // `@autoreleasepool` is used most commonly when many large, temporary objects are instantiated within a single block (eg in a for-loop). If they do not need to be used outside the for loop block, then each iteration can be wrapped in `@autoreleasepool`, so that they will be autoreleased as soon as each run through the loop ends, preventing a sudden, drastic increase in memory usage and possible performance issues or, in a worst case scenario, a stack overflow.
5. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

    ```objc
    @interface LSIPerson: NSObject

    @property (nonatomic, copy) NSString *name;

    - (instancetype)initWithName:(NSString *)name;
    - (instancetype)personWithName:(NSString *)name;

    @end

    @implementation
    // ...
    // `initWithName` would go here
    // ...

    - (instancetype)personWithName:(NSString *)name
    {
        return [[[LSIPerson alloc] initWithName:name] autorelease];
    }

    @end
    ```
