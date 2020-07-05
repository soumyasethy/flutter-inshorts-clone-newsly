![alt text](https://github.com/soumyasethy/flutter-inshorts-clone-newsly/blob/master/iOS_newsly.gif)
![alt text](https://github.com/soumyasethy/flutter-inshorts-clone-newsly/blob/master/android_newsly.gif)

# Built with Flutter
Newly is clone mobile app of Inshorts news App UI. 

## Features
- Swip up for next news story
- Swipe down for previous news story.
- Tap at bottom action button to read full story on published website.
- Tap on share icon to share the news in WhatsApp, Facebook or anywhere.


###### Gesture Swipe Up and Down handle by **Dismissible** widget
> code snippet
```
Dismissible(
          background: newsCard(prevIndex),
          child: newsCard(index),
          secondaryBackground: newsCard(nextIndex),
          resizeDuration: Duration(milliseconds: 10),
          key: Key(index.toString()),
          direction: DismissDirection.vertical,
          onDismissed: (direction) {
            updateContent(direction);
          },
        )
```


## Use Case
This can be replaced with the real news api call.

## Looking for news api?
send email at sethy.soumyaranjan@gmail.com



