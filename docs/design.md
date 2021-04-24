```
 _____      _   ______ _             ______          _              ______                    __   
|  _  |    | |  | ___ (_)            |  _  \        (_)             |  _  \                  /  |  
| | | | ___| | _| |_/ /_ _ __   ___  | | | |___  ___ _  __ _ _ __   | | | |___   ___  __   __`| |  
| | | |/ __| |/ /  __/| | '_ \ / _ \ | | | / _ \/ __| |/ _` | '_ \  | | | / _ \ / __| \ \ / / | |  
\ \/' / (__|   <| |   | | |_) |  __/ | |/ /  __/\__ \ | (_| | | | | | |/ / (_) | (__   \ V / _| |_ 
 \_/\_\\___|_|\_\_|   |_| .__/ \___| |___/ \___||___/_|\__, |_| |_| |___/ \___/ \___|   \_/  \___/ 
                        | |                             __/ |                                      
                        |_|                            |___/                                       
```
<!-- vscode-markdown-toc -->
* 1. [Essentials](#Essentials)
* 2. [Nice to have](#Nicetohave)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


##  1. <a name='Essentials'></a>Essentials
- Execution Locally
- Parsing DSL 
    - Grammar for parsing
        - Parsing Script can accept Haskell functions as utility
        - step1 `+` step2 -- run sequentially
        - step1 `|` step2 -- pipe step1 to step2
        - step1 `&` step2 -- run concurrently
        - Branching
            - `[item1, item2, item2] * step1` -- run these items with step 1 concurrently
            - Merge 
                - `[item1, item2, item2] * step1 > mergeStep` -- run these items with step 1 concurrently then merge in mergeStep
    - Input / Output file dependency for steps
- Utility
    - Timing of steps 
    - Max memory usage
    - Process usage CPU
    - Put into simple db? sqlite3?


##  2. <a name='Nicetohave'></a>Nice to have
- Parsing
    - `foldl [item1, item2, item3] step1`
    - `foldr [item1, item2, item3] step2`
- HPC execution
- Docker integration