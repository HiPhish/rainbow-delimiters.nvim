(element
  (STag
    "<" @delimiter
    (Name) @delimiter
    ">" @delimiter)
  (ETag
    "</" @delimiter
    (Name) @delimiter
    ">" @delimiter @sentinel))@container

(element
  (EmptyElemTag
    "<" @delimiter
    (Name) @delimiter
    "/>" @delimiter @sentinel)) @container
