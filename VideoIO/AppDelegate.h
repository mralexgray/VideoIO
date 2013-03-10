#import <Python/Python.h>
#import <AtoZ/AtoZ.h>



@interface AppDelegate : NSObject <NSApplicationDelegate>

//@property (strong) AZSimpleView *rtmpIsOn, *sipIsOn;

@property (nonatomic, strong) NSTask *rtmplite, *sipd;

//@property (assign) IBOutlet SIPRunner *runner;
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSDictionary *cities;

@end
