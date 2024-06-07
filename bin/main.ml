let () =
  if Array.length Sys.argv <> 5 then
    failwith "usage: brdocaml [addr] [port] [certfile] [keyfile]"

let addr = Array.get Sys.argv 1
let port = Array.get Sys.argv 2 |> int_of_string
let certfile = Array.get Sys.argv 3
let keyfile = Array.get Sys.argv 4
let () = App.run addr port certfile keyfile
