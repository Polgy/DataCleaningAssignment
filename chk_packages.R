#load packages
# credit Roger Peng course
local({
  message("checking if depending packages are loaded. This may take a minute or two...\n")
  checkPkgs <- function(pkgs) {
    pkg.inst <- installed.packages()
    #pkgs <- c("data.table")
    have.pkg <- pkgs %in% rownames(pkg.inst)
    
    if(any(!have.pkg)) {
      need <- pkgs[!have.pkg]
      cat ("packages need to be installed:", need)
      r <- readline("Install necessary packages [y/n]? ")
      if(tolower(r) == "y") {
        need <- pkgs[!have.pkg]
        message("installing packages ",
                paste(need, collapse = ", "))
        install.packages(need)
      }
    }
  }
   assign("checkPkgs", checkPkgs, globalenv())
})  