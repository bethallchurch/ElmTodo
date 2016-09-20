import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)


main = App.program
    { init = init 
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Todo =
    { text : String
    , completed : Bool
    }

type alias Model =
    { input : String
    , todos : List Todo 
    }


-- INIT

init : (Model, Cmd Msg)
init = 
    ({ input = "", todos = [] }, Cmd.none)


-- UPDATE

type Msg = AddTodo | InputChange String

newTodo : String -> Todo
newTodo text =
    { text = text, completed = False }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 
        AddTodo ->
            ({ model | todos = newTodo model.input :: model.todos }, Cmd.none)

        InputChange newInput ->
            ({ model | input = newInput }, Cmd.none)


-- VIEW

viewTodo : Todo -> Html Msg
viewTodo todo =
    li [] 
       [ p [] [ text todo.text ]
       , input [ type' "checkbox", checked todo.completed ] []
       ]

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "To Do List" ]
        , input [ onInput InputChange ] []
        , button [ onClick AddTodo ] [ text "Create Todo" ]
        , ul [] (List.map viewTodo model.todos)
        ]


-- SUBSCRIPTIONS        

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none