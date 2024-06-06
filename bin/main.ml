let addr = Array.get Sys.argv 1
let port = Array.get Sys.argv 2 |> int_of_string
let () = App.run addr port
