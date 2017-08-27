open Core

type t =
  { i : int
  ; f : float
  } [@@deriving bin_io, sexp]

let () =
  Sexp.to_string_hum [%sexp ([3; 4; 5] : int list)] |> print_endline

let _ = [%sexp (1 : int)]

let param =
  let open Command.Let_syntax in
  let%map name =
    Command.Param.flag "-name" ~doc:"NAME Name to say hello to" (Command.Param.optional_with_default "Zander" Command.Param.string)
  in
  fun () ->
    print_endline name

let command = Command.basic' ~summary:"Command summary!" param

let () = Command.run command
