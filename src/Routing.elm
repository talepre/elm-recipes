module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (RecipeId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RecipesRoute top
        , map RecipeRoute (s "recipes" </> string)
        , map RecipesRoute (s "recipes")
        , map AddRecipeRoute (s "addrecipe")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

recipesPath : String
recipesPath =
    "#recipes"


recipePath : RecipeId -> String
recipePath id =
    "#recipes/" ++ id

addRecipePath : String
addRecipePath =
    "#addrecipe"