#import <UIKit/UIKit.h>

int greeting(void);

int main(int argc, char *argv[]) {
  return greeting() == 42 ? UIApplicationMain(argc, argv, nil, nil) : 1;
}
