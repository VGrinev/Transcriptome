###################################################################################################
##  A complete R-wrap for format converting of different positional matrices.                    ##
##  (c) GNU GPL Vasily V. Grinev, 2019. grinev_vv[at]bsu.by                                      ##
###################################################################################################
### Arguments of function:
##  d.work  - character string giving the path to and name of work directory.
##  m.input - character string giving the name of TXT file in tab-delimited format containing
#             original positional matrix.
##  m1      - character string giving the type of original positional matrix. Default value is
#             "ppm" (positional probability matix).
##  p.count - logical agrument. If TRUE (default) then pseudocounts will be added
#             to the positional matrix with zero value(-s).
##  m2      - character string giving the type of output positional matrix. Default value is
#             "pwm" (positional weight matix).
##  bg.freq - background frequency of nucleotides. By default, the frequency is uniform.
matrixCoverter = function(d.work, m.input, m1 = "ppm", p.count = TRUE, m2 = "pwm",
                          bg.freq = c(A = 0.25, C = 0.25, G = 0.25, T = 0.25)){
##  Loading of original positional matrix.
x = read.table(file = paste(d.work, m.input, sep = "/"),
               sep = "\t",
               header = FALSE,
               quote = "\"",
               row.names = 1,
               as.is = TRUE)
##  Converting of positional probability matix into alternative formats.
y = x
if (m1 == "ppm"){
#   Calculation of pseudocount adjusted positional probability matix.
    if (p.count == "TRUE"){
        y = y + (min(y[y > 0]) * 0.001)
        y = round(x = t(t(y)/apply(X = y, MARGIN = 2, FUN = sum)), digits = 10)
   }
#   Calculation of positional weight matix.
    if (m2 == "pwm"){
        y = round(x = log2(y/bg.freq), digits = 10)
   }
}
##  Returning the final matrix.
return(y)
}
