(element
  (STag
    "<" @delimiter
    (Name) @delimiter
    ">" @delimiter)
  (ETag
    "</" @delimiter
    (Name) @delimiter
    ">" @delimiter))@container

(element
  (EmptyElemTag
    "<" @delimiter
    (Name) @delimiter
    "/>" @delimiter)) @container
