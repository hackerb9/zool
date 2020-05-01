# zool

Always use Zoom *web*client under GNU/Linux by registering a handler
for zoommtg:// URIs

## What? Why? Huh?

Zoom is a video conferencing service that became quite popular during
the COVID-19 pandemic of 2020. Unfortunately, it is currently rather
aggressive about pushing its proprietary client software on every
participant's computer. Further, because it is closed source, there
have been numerous security and privacy issues. For those and other
reasons, many people are turning to open solutions such as
[Jitsi](jitsi.org), when they have a choice.

But Zoom isn't always optional. When that happens, it's good to have
*Zool* installed. When clicking on a Zoom meeting link, Zool will load
up the Zoom *web client* which uses the builtin video conferencing
that already exists in Free Software web-browsers, such as
[Chromium](https://www.chromium.org/developers/how-tos/get-the-code).
No need to trust a proprietary, closed-source client on your computer.
(Of course, your data is still being sent through Zoom's networks, so
maybe suggest the host consider another alternative next time)..

## Installation

```
git clone https://github.com/hackerb9/zool
cd zool
make install
```

That is all.

## Bugs

Zool currently attempts to run Chromium or Google Chrome even if your
default web browser is Firefox. This is because Zoom (as of May 2020)
does not allow audio for Firefox, although video does work. After that
bug is fixed, Zool will be changed to use your default browser.

## Nitty gritty

The [`zool.desktop`](https://github.com/hackerb9/zool/blob/master/zool.desktop)
file specifies the handler for MIME type `x-schema-zoommtg` to be a
program named `zool`. Putting it in ~/.local/share/applications/ is
usually enough to get the handler registered.

The [`zool`](https://github.com/hackerb9/zool/blob/master/zool) 
shell script simply transmogrifies the `zoommtg://` URI so that it
becomes a standard `https://` address using Zoom's webclient and opens
it. For example:

```
zoommtg://zoom.us/join?action=join&confid=dXNzPTVhNDYyMjAxLjAzRXdVclZEeWRpRDlRTC16WU1FM05FVnN6c0pFVk9uanpRWlJjQjVQUzAzbkp3eVkwU1RnZ1g5U2pScDhjakRfOG5KeTRzcXhCSHVJVG1La2Z5aGlBJTNEJTNEJnRpZD01OTVkMzMzMDdmYTc0OTk5YjcyYWQ3ZTUzMjllNmFiMA%3D%3D&confno=91265111161&zc=0&pwd=UE54Y3AxbHRvRlA2azQ1K2VWMEF2Zz09&pk=&mcv=0.92.11227.0929&browser=chrome
```

would become

```
https://zoom.us/wc/join/91265111161?zc=0&pwd=UE54Y3AxbHRvRlA2azQ1K2VWMEF2Zz09&pk=&mcv=0.92.11227.0929&browser=chrome
```

Since Zool doesn't actually bother to parse the CGI arguments, it's
quite possible that the simple string substitution will break if Zoom
changes its URI format. (For example, putting the pwd before confno).
However, instead of trying to make this more robust with no data, I'm
going to wait for more samples of actual Zoom URLs from users.

Please report a bug with the "zoommtg" URI if Zool doesn't work for you.

