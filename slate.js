
//var left = {
//    'x': 'screenOriginX',
//    'y': 'screenOriginY',
//    'width': 'screenSizeX/2',
//    'height': 'screenSizeY',
//};
//
//var right = {
//    'x': 'screenOriginX + screenSizeX/2',
//    'y': 'screenOriginY',
//    'width': 'screenSizeX/2',
//    'height': 'screenSizeY',
//};
//
//
////half screen right.
//slate.bind('right:ctrl,cmd', function(win) {
//    var screen = slate.screen().rect();
//    var win_rect = win.rect();
//
//    // if we are at the edge of a screen on the right.
//    if(Math.abs(screen.x + screen.width - win_rect.x - win_rect.width) < 5) {
//        var curr_screen = slate.screen().id();
//        slate.log(curr_screen);
//        if(curr_screen < slate.screenCount() - 1) {
//            var shift_screen = _.clone(left);
//            shift_screen['screen'] = curr_screen + 1;
//
//            win.doOperation(slate.operation('move', shift_screen));
//        }
//    } else {
//        win.doOperation(slate.operation('move', right));
//    }
//});


//half screen.
//slate.bind('left:ctrl,cmd', function(win) {
//    var screen = slate.screen().rect();
//    var win_rect = win.rect();
//
//    // if we are at the edge of a screen on the left.
//    if(screen.x == win_rect.x) {
//        var curr_screen = slate.screen().id();
//        if(curr_screen > 0) {
//            var shift_screen = _.clone(right);
//            shift_screen['screen'] = curr_screen - 1;
//
//            win.doOperation(slate.operation('move', shift_screen));
//        }
//    } else {
//        win.doOperation(slate.operation('move', left));
//    }
//});
//
////center
//slate.bind('down:ctrl,cmd', function(win) {
//    win.doOperation(slate.operation('move', {
//        'x': 'screenOriginX + screenSizeX/4',
//        'y': 'screenOriginY + screenSizeY/4',
//        'width': 'screenSizeX/2',
//        'height': 'screenSizeY/2',
//    }));
//});

var moveFull = S.op("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
var moveLeft50 = moveFull.dup({ "width" : "screenSizeX/2" });
var moveRight50 = moveLeft50.dup({ "x" : "screenSizeX/2" });

S.bnda({
    'f:ctrl,alt,cmd' : moveFull,
    'left:ctrl,alt,cmd' : moveLeft50,
    'right:ctrl,alt,cmd' : moveRight50,
    'r:alt' : S.op('relaunch'),
    'space:shift,cmd' : S.op("grid")
});
  
// Log that we're done configuring
S.log('[SLATE] -------------- Finished Loading Config --------------');
