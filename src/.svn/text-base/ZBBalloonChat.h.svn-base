// +------------------------------------------------------------------------+
// | iText - iPhone SMS Manager                                             |
// +------------------------------------------------------------------------+
// | Copyright (c) 2007 Zack Bartel                                         |
// +------------------------------------------------------------------------+
// | This program is free software; you can redistribute it and/or          |
// | modify it under the terms of the GNU General Public License            | 
// | as published by the Free Software Foundation; either version 2         | 
// | of the License, or (at your option) any later version.                 |
// |                                                                        |
// | This program is distributed in the hope that it will be useful,        |
// | but WITHOUT ANY WARRANTY; without even the implied warranty of         |
// | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          |
// | GNU General Public License for more details.                           |
// |                                                                        |
// | You should have received a copy of the GNU General Public License      |
// | along with this program; if not, write to the Free Software            |
// | Foundation, Inc., 59 Temple Place - Suite 330,                         |
// | Boston, MA  02111-1307, USA.                                           |
// +------------------------------------------------------------------------+
// | Author: Zack Bartel <zack@bartel.com>                                  |
// +------------------------------------------------------------------------+ 
//
//  ZBBalloonChat.h
//  iText
//
//  Created by Zack Bartel on 3/23/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBSMSConversation.h"

#define HTML_TOP @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\
	\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\
<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\">\
<head>\
<title>Text Messages</title>\
<style>\
\
div.CBmsg {\
                  display: table; \
            margin-bottom: 0.5em;\
}\
\
\
div.CBmsgR {\
                    float: right;\
               text-align: right;\
           }\
           \
div.CBmsgL .CBcontent {\
  padding-left: 12px;\
}\
           \
\
          \
div.CBtxt {\
                  display: table-cell;  \
                 position: relative;\
                   margin: 0px auto;\
                min-width: 8em;\
                max-width: 760px;\
                  z-index: 1;\
              margin-left: 12px;\
           }\
\
div.CBiconL { \
                  display: table-cell; \
           vertical-align: bottom;\
            padding-right: 22px; /* 10+12 */\
            \
            }\
\
div.CBiconR {\
                  display: table-cell; \
           vertical-align: bottom;\
             padding-left: 10px;\
            }\
\
div.CBiconR > img {\
		  padding: 0px;\
		    width: 32px;\
		   height: 32px;\
		}\
\
div.CBiconL > img {\
		  padding: 0px;\
		    width: 32px;\
		   height: 32px;\
		}\
\
.CBblueL .CBcontent,\
.CBblueL .CBt,\
.CBblueL .CBb,\
.CBblueL .CBb div {\
 background:transparent url(BubbleBlueL800x1600.png) no-repeat top right;\
}\
\
.CBblueR .CBcontent,\
.CBblueR .CBt,\
.CBblueR .CBb,\
.CBblueR .CBb div {\
 background:transparent url(BubbleBlueR800x1600.png) no-repeat top right;\
}\
\
.CBpinkL .CBcontent,\
.CBpinkL .CBt,\
.CBpinkL .CBb,\
.CBpinkL .CBb div {\
 background:transparent url(BubblePinkL800x1600.png) no-repeat top right;\
}\
\
.CBpinkR .CBcontent,\
.CBpinkR .CBt,\
.CBpinkR .CBb,\
.CBpinkR .CBb div {\
 background:transparent url(BubblePinkR800x1600.png) no-repeat top right;\
}\
\
.CBltgreyL .CBcontent,\
.CBltgreyL .CBt,\
.CBltgreyL .CBb,\
.CBltgreyL .CBb div {\
 background:transparent url(BubbleLtGreyL800x1600.png) no-repeat top right;\
}\
\
.CBltgreyR .CBcontent,\
.CBltgreyR .CBt,\
.CBltgreyR .CBb,\
.CBltgreyR .CBb div {\
 background:transparent url(BubbleLtGreyR800x1600.png) no-repeat top right;\
}\
\
.CBtxt .CBcontent {\
 position:relative;\
 zoom:1;\
 _overflow-y:hidden;\
 padding:5px 12px 0px 0px;\
}\
\
\
.CBtxt .CBt {\
 /* top+left vertical slice */\
 position:absolute;\
 left:0px;\
 top:0px;\
 width:12px; /* top slice width */\
 margin-left:-12px;\
 height:100%;\
 _height:1600px; /* arbitrary long height, IE 6 */\
 background-position:top left;\
}\
\
.CBtxt .CBb {\
 /* bottom */\
 position:relative;\
 width:100%;\
}\
\
.CBtxt .CBb,\
.CBtxt .CBb div {\
 height:10px; /* height of bottom cap/shade */\
 font-size:1px;\
}\
\
.CBtxt .CBb {\
 background-position:bottom right;\
}\
\
.CBtxt .CBb div {\
 position:relative;\
 width:12px; /* bottom corner width */\
 margin-left:-12px;\
 background-position:bottom left;\
}\
body {\
    background: #dfdfdf url(Texture.jpg);\
}\
</style>\
</head>\
\
<body style=\"width:500px;\">\
"

#define HTML_CHAT_RIGHT @"<div class=\"CBmsg CBmsgR CBblueR\">\
  <div class=\"CBtxt\">\
    <div class=\"CBcontent\">\
      <div class=\"CBt\"></div>\
      %@\
    </div>\
    <div class=\"CBb\"><div></div></div>\
  </div>\
  <div class=\"CBiconR\"><img src=\"me.png\"></div>\
</div>\
<br clear=all>\
"

#define HTML_CHAT_LEFT @"<div class=\"CBmsg CBmsgL CBltgreyL\">\
 <div class=\"CBiconL\"><img src=\"person.png\"></div>\
  <div class=\"CBtxt\">\
    <div class=\"CBcontent\">\
      <div class=\"CBt\"></div>\
    %@\
    </div>\
    <div class=\"CBb\"><div></div></div>\
  </div>\
</div>\
<br clear=all>\
"

#define HTML_BOTTOM @"<script type=\"text/javascript\">\
//var objDiv = document.body;\
//objDiv.scrollTop = objDiv.scrollHeight;\
</script></body></html>"

#define HTML_DATE @"<div style=\"text-align: center; color: grey;\">%@</div>"

@interface ZBBalloonChat : NSObject 
{
    
}

+ (NSString *) urlForConversation: (ZBSMSConversation *)conversation;

@end
