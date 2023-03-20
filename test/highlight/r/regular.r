# call
suppressWarnings(library(datasets))

# outer subset, inner subset2
mtcars[mtcars[[1, 2]], ]

# if ladder, inner brace_list
var <- 10
if (var > 5) {
    print(paste(var, "is greater than 5"))
    if (var < 10) {
        print(paste(var, "is less than 10"))
    }
}
