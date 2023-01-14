"  Copyright 2023 Alejandro "HiPhish" Sanchez
"  Copyright 2020-2022 Chinmay Dalal
"
"  Licensed under the Apache License, Version 2.0 (the "License");
"  you may not use this file except in compliance with the License.
"  You may obtain a copy of the License at
"
"      http://www.apache.org/licenses/LICENSE-2.0
"
"  Unless required by applicable law or agreed to in writing, software
"  distributed under the License is distributed on an "AS IS" BASIS,
"  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"  See the License for the specific language governing permissions and
"  limitations under the License.

highlight default TSRainbowRed     guifg=#cc241d ctermfg=Red
highlight default TSRainbowOrange  guifg=#d65d0e ctermfg=White
highlight default TSRainbowYellow  guifg=#d79921 ctermfg=Yellow
highlight default TSRainbowGreen   guifg=#689d6a ctermfg=Green
highlight default TSRainbowCyan    guifg=#a89984 ctermfg=Cyan
highlight default TSRainbowBlue    guifg=#458588 ctermfg=Blue
highlight default TSRainbowViolet  guifg=#b16286 ctermfg=Magenta

lua require "ts-rainbow.module".register()

" vim:tw=79:ts=4:sw=4:noet:
