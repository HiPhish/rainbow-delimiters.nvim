(flow_mapping
  "{" @opening
  (flow_pair ":" @intermediate)*
  "}" @closing) @container

(flow_sequence
  "[" @opening
  "]" @closing) @container
