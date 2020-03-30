{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies #-}
import Yesod

{-
Declare Yesod "Foundation" datatype
Used to store application-wide information and settings and also to tie all the typeclass instances together
Must be an instance of the Yesod typeclass
-}
data HelloWorld = HelloWorld
instance Yesod HelloWorld

--Specify routes using Template Haskell function "mkYesod" and QuasiQuoter "parseRoutes"
mkYesod "HelloWorld" [parseRoutes|
/ HomeR GET
|]

{-
Define handler function for GET requests on our Home Resource route (HomeR)
"defaultLayout" wraps content in basic page HTML tags, this can be overriden to do more interesting stuff
"whamlet" QuasiQuoter converts Hamlet (HTML templating DSL) syntax into a "Widget"
Widgets are encapsulated blocks of HTML, CSS and JS, which work how you'd expect
-}
getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

--run warp webserver with default settings on port 3000 and pass Foundation datatype to run our yesod application
main :: IO ()
main = warp 3000 HelloWorld

{-
stack runghc yesod-book/helloworld.hs
stack runghc -- -ddump-splices -ddump-to-file -ddump-file-prefix=yesod-book/helloworld- yesod-book/helloworld.hs
-}
