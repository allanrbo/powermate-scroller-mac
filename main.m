#import <Foundation/Foundation.h>
#import <IOKit/hid/IOHIDManager.h>
#import <ApplicationServices/ApplicationServices.h>

void handleInput(void *context, IOReturn result, void *sender, IOHIDValueRef value) {
    IOHIDElementRef element = IOHIDValueGetElement(value);
    uint32_t usage = IOHIDElementGetUsage(element);
    uint32_t usagePage = IOHIDElementGetUsagePage(element);

    // Griffin PowerMate rotation is usage 0x0001 in usage page 0x0001 (Generic Desktop -> Rotation)
    if (usagePage == 0x01 && (usage == 0x37 || usage == 0x30)) {
        CFIndex intValue = IOHIDValueGetIntegerValue(value);
        if (intValue != 0) {
            // printf("Scrolling: %ld\n", (long)intValue);
            CGEventRef scroll = CGEventCreateScrollWheelEvent(
                NULL,
                kCGScrollEventUnitLine, // kCGScrollEventUnitPixel,
                1,
                -intValue * 3
            );
            CGEventPost(kCGHIDEventTap, scroll);
            CGEventPost(kCGSessionEventTap, scroll);
            CFRelease(scroll);
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IOHIDManagerRef manager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeSeizeDevice);

        NSDictionary *criteria = @{
            @kIOHIDVendorIDKey: @(0x077d),
            @kIOHIDProductIDKey: @(0x0410)
        };
        IOHIDManagerSetDeviceMatching(manager, (__bridge CFDictionaryRef)criteria);

        IOHIDManagerRegisterInputValueCallback(manager, handleInput, NULL);
        IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);

        if (IOHIDManagerOpen(manager, kIOHIDOptionsTypeNone) != kIOReturnSuccess) {
            NSLog(@"Failed to open IOHIDManager.");
            return 1;
        }

        NSLog(@"Listening for PowerMate rotation to generate scroll events...");
        CFRunLoopRun();

        CFRelease(manager);
    }
    return 0;
}
