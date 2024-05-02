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

foobar <- function(num) {
    for (i in 1:5) {
      print(i)
    }

    while (TRUE) {
        break
    }

    x <- "a"
    v <- switch(x, "a"="apple", "b"="banana", "c"="cherry")

    if (num > 0) {
        return("Positive")
    } else if (num < 0) {
        return("Negative")
    } else {
        return("Zero")
    }
}
