## This sciprt file is built for programming assignment2 in Coursera R Programming. 
## Function "makeCacheMatrix" creates special "matrix object that can cache 
## its inverse matrix. Function "cacheSolve" computes the inverse matrix of the
## special "matrix" returned by "makeCacheMatrix". If the inverse is already 
## calculated, then this function retrieves the inverse from the Cache. 

## makeCacheMatrix: This function creates a special "matrix" object 
##                  that can cache its inverse matrix.

makeCacheMatrix <- function(x = matrix()){
    InvMat <- NULL
    set <- function(y){
        x <<- y
        InvMat <<- NULL
    }
    get <- function() x
    setInverse <- function(solve) InvMat <<- solve
    getInverse <- function() InvMat
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## cacheSolve: This function computes the inverse of the special "matrix" 
##             returned by makeCacheMatrix above. If the inverse is 
##             already calculated (and the matrix has not be changed), 
##             then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...){
    InvMat <- x$getInverse()
    if(!is.null(InvMat)){
        message("getting cached data")
        return(InvMat)
    }
    data <- x$get()
    InvMat <- solve(data, ...)
    x$setInverse(InvMat)
    InvMat
}