; Creation function identifiers

; Vide/Any function to a string arg
(function_call
  name: (identifier) @create_name
  ; (#eq? @create_name "create")
)

; Fusion/Any method call to a string arg 'scope:New'
(function_call 
  name: (method_index_expression) @create_name
)

; (function_call
;   arguments: (arguments (string content: (string_content) @instance_name))
; )
