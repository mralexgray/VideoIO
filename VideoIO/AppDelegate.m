
#import "AppDelegate.h"
#import "Taskit.h"

@implementation AppDelegate
@synthesize  p2psip, rtmplite;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
 	self.cities = @{ @"Beverly Hills, CA" : @(90209), @"Miami, FL": @(33190), @"Beaver, WV": @(25813) };
	[self checkWeather];
	[self startSIP];

	self.p2psip = Taskit.task;
    p2psip.launchPath = @"/usr/bin/python";
	p2psip.currentDirectoryPath = [[NSBundle.mainBundle resourcePath]stringByAppendingPathComponent:@"p2p-sip/src"];
	p2psip.environment		= @{ @"PYTHONPATH" : @"app:external:." };
	p2psip.arguments 			= @[@"app/sipd.py",@"-d"];
    p2psip.receivedOutputString = ^void(NSString *output) {
        NSLog(@"%@", output);
    };
    [task launch];

}
-(void) startSIP {

	NSPipe *stdOutPipe, *stdErrPipe = NSPipe.pipe;
	NSTask* task 			= NSTask.new;
	task.launchPath	 		= @"/usr/bin/python";
	task.currentDirectoryPath = [[NSBundle.mainBundle resourcePath]stringByAppendingPathComponent:@"p2p-sip/src"];
	task.environment		= @{ @"PYTHONPATH" : @"app:external:." };
	task.arguments 			= @[@"app/sipd.py",@"-d"];

	task.standardInput		= NSPipe.pipe;	// NSLog breaks if we don't do this...
	task.standardOutput 	= stdOutPipe;
	task.standardError		= stdErrPipe;

//cd p2p-sip-read-only/src
//$ PYTHONPATH=app:external:.
//$ export PYTHONPATH
//$ python app/sipd.py -d
//On second terminal, download rtmplite and run its siprtmp module as follows. This will run siprtmp on port 1935 by default.
//
//$ svn checkout http://rtmplite.googlecode.com/svn/trunk/ rtmplite-read-only
//$ cd rtmplite-read-only
//$ PYTHONPATH=../p2p-sip-read-only/src:.
//$ export PYTHONPATH
//$ python siprtmp.py -d
}

- (NSString*)weatherForCity:(NSString*)city
{
	NSPipe *stdOutPipe, *stdErrPipe;
	NSTask* task 			= NSTask.new;
	task.launchPath	 		= @"/usr/bin/python";
	NSString *scriptPath 	= [NSBundle.mainBundle pathForResource:@"weather" ofType:@"py"];
	task.arguments 			= @[scriptPath, [_cities[city] stringValue]];
	task.standardInput		= NSPipe.pipe;	// NSLog breaks if we don't do this...
	stdOutPipe				= NSPipe.pipe;
	stdErrPipe				= NSPipe.pipe;
	task.standardOutput 	= stdOutPipe;
	task.standardError		= stdErrPipe;
//	NSLog(@"Task: %@", task);
	[task launch];
	NSData* data = [[stdOutPipe fileHandleForReading] readDataToEndOfFile];
	[task waitUntilExit];

	NSInteger exitCode = task.terminationStatus;
	return  exitCode != 0 	? [NSString.alloc initWithFormat:@"Error!  %ld", exitCode]
							: [NSString.alloc initWithBytes: data.bytes length:data.length encoding: NSUTF8StringEncoding];
}

- (void)checkWeather 
{
	dispatch_group_t group = dispatch_group_create();
	NSMutableArray* results = NSMutableArray.new;
	dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[_cities.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSMutableString* result = [self weatherForCity:obj].mutableCopy;
		[result replaceCharactersInRange:(NSRange){result.length -2,2} withString:@""];
			@synchronized(results)
			{
				if (result) [results addObject:  [NSString stringWithFormat:@"Weather for:%@  %@", obj, result]];
			}
		}];
	});

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self scriptsDidFinishWithResults: results];
    });
}

- (void) scriptsDidFinishWithResults: (NSArray*)results
{
	NSLog(@"%@", results);
}

@end
