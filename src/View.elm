module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, RecipeId)
import Msgs exposing (Msg)
import Recipes.Details
import Recipes.List
import Recipes.Add
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.RecipesRoute ->
            Recipes.List.view model

        Models.RecipeRoute id ->
            recipeDetailsPage model id

        Models.AddRecipeRoute ->
            Recipes.Add.view
            
        Models.NotFoundRoute ->
            notFoundView


recipeDetailsPage : Model -> RecipeId -> Html Msg
recipeDetailsPage model recipeId =
    case model.recipes of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success recipes ->
            let
                maybeRecipe =
                    recipes
                        |> List.filter (\recipe -> recipe.id == recipeId)
                        |> List.head
            in
                case maybeRecipe of
                    Just recipe ->
                        Recipes.Details.view recipe

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]