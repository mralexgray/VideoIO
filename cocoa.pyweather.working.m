#import <Foundation/Foundation.h>
#import <Python/Python.h>


void runP(){
	
	Py_Initialize();
    
   PyImport_AddModule("lib");
   PyImport_AddModule("app");
	static const char* args[] = { "weather.py", "10011" };
	
	PySys_SetArgv(2, &args);
	NSString *path= @"/Volumes/2T/ServiceData/git/VideoIO/VideoIO/weather.py";
//	NSString *path= @"/cgi/hostname.py";
//	NSString *path= @"/cgi/repeater.py";
	//";
   NSString *py = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//	NSLog(@"content: %@", py);
	PyRun_SimpleString([py UTF8String]);
	return;
}

int main(int argc, char *argv[]) {
	@autoreleasepool {

	runP();
		
	}
}


// = [[NSBundle mainBundle] bundlePath];

//"[path stringByAppendingPathComponent:@"Contents/Resources/HandleBar/view.py'"];
 //f stringByAppendingString:path];
    

