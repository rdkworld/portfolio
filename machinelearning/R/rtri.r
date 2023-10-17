qtri <- function(p, a, b, c) {
  if (!all(a <= c && c <= b && a < b)) next
  
  ifelse(p > 0 & p < 1,
         ifelse(p <= ptri(c, a, b, c),
                a+sqrt((a^2-a*b-(a-b)*c)*p),
                b-sqrt(b^2-a*b+(a-b)*c+(a*b-b^2-(a-b)*c)*p)),
         NA)
}

rtri <- function(n, a, b, c) {
  if (!all(a <= c && c <= b && a < b)) next
  
  qtri(runif(n, min = 0, max = 1), a, b, c)
}
