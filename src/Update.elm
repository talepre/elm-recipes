module Update exposing (..)

import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import Models exposing (Model, Recipe)
import Commands exposing (saveRecipeCmd, deleteRecipeCmd, fetchRecipes)
import RemoteData exposing (WebData)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRecipes response ->
            ( { model | recipes = response }, Cmd.none )
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
        Msgs.Query newQuery ->
            ( {model | query = newQuery}, Cmd.none )
        Msgs.Name newName ->
            let
                preNewRecipe =
                    model.newRecipe
                newRecipe =
                    { preNewRecipe | name = newName }           
            in
                ( {model | newRecipe = newRecipe}, Cmd.none )
        Msgs.Description newDescription ->
            let
                preNewRecipe =
                    model.newRecipe
                newRecipe =
                    { preNewRecipe | description = newDescription }           
            in
                ( {model | newRecipe = newRecipe}, Cmd.none )
        Msgs.AddRecipe ->
            let
                newRecipe =
                    model.newRecipe
            in
                ( model, saveRecipeCmd newRecipe )
        Msgs.OnRecipeSave (Ok recipe) ->
            ( updateRecipe recipe model, Cmd.none )

        Msgs.OnRecipeSave (Err error) ->
            ( model, Cmd.none )
        Msgs.DeleteRecipe recipe ->
            ( model, deleteRecipeCmd recipe)
        Msgs.OnRecipeDelete (Ok bool) -> 
            (model, Cmd.none)
        Msgs.OnRecipeDelete (Err error) ->
            (model, Cmd.none)
        Msgs.OnFetchIngredients response ->
            ( { model | ingredients = response }, Cmd.none )
        Msgs.OnFetchUnits response ->
            ( { model | units = response }, Cmd.none )
        Msgs.AddIngredientField ->
            let
                newRecipe =
                    model.newRecipe
                emptyIngredient =
                    [{ ingredientId = "",
                    unitId = "",
                    amount = 0
                    }]
                newIngredientList =
                    newRecipe.ingredients ++ emptyIngredient
                updatedNewRecipe =
                    { newRecipe | ingredients = newIngredientList }
            in
                ( { model | newRecipe = updatedNewRecipe }, Cmd.none )
        Msgs.UnitId newUnitId ->
            ( model, Cmd.none )
        Msgs.IngredientId newIngredientId ->
            ( model, Cmd.none )
        Msgs.Amount newAmount ->
            ( model, Cmd.none )
                    

updateRecipe : Recipe -> Model -> Model
updateRecipe newRecipe model =
    let
        recipeList =
            model.recipes
        recipe =
            RemoteData.succeed [newRecipe]
        newRecipeList
            = RemoteData.map2 (List.append) recipeList recipe
    in
        { model | recipes = newRecipeList }















