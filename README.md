# Luna - Fertility Tracker 🌙

![]
(http://img.wallpaperfolder.com/f/4FE4BAB1927C/fonds-cran-tumblr-pc-et.jpg)

# Setup

1. `$ git clone https://github.com/loganblevins/Luna.git`
2. `$ cd <yourPathToLuna>`
3. `$ sudo gem install cocoapods`
4. `$ pod install`
5. **Open 'Luna.xcworkspace'**
6. :sunglasses:

# Contributing

1. Branch from **master**
2. Open **Pull Request**
3. Wait for :shipit:
4. Merge into **master**

# Style

- Clamshell curly brackets

```
if let _ = textField.text where !textField.text.isEmpty
{
    print( "Non-empty textField" )
}
else
{
    print( "Empty textField" )
}
```

- Comments with empty ending line

```
// `Characters` view doesn't honor certain characters.
// Rather, it treats characters as they appear visually.
// `utf16` view honors all characters, regardless of visuals.
//
var count: Int
{
    return self.utf16.count
}
```
- Spacing between operators

```
func contains( find: String ) -> Bool
{
    return range( of: find ) != nil
}
```

- Use **tabs** in Xcode...(not spaces)
