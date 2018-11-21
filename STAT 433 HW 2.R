
question1 <- function(x,n=0)
{
  sum <- 0
  for (i in 0:n)#Progresses through each num 0-n
    sum <- sum + x^i#Adds x^i to sum
  
  return(sum)
}
x <- 2.5#Can be changed
n <- 9#Can be changed, must be an int
question1(x, n)

question2While <- function(x, n=0)
{
  sum <- 0#The sum
  i <- 0#The incrementer
  while (i <= n)#Iterates 0-n
  {
    sum <- sum + x^i#Adds x^i to sum
    i <- i + 1#Increments i
  }
  return(sum)#Returns sum
}
x <- 2.5#Can be changed
n <- 9#Can be changed, must be an int
question2While(x, n)

#Creates a vector of length n+1 of x^0, x^1, ..., x^n, sums the vector, and returns the sum
question2Vector <- function(x, n=0)
{
  return(sum(c(x^(0:n))))
}
x <- 2.5#Can be changed
n <- 9#Can be changed, must be an int
question2Vector(x, n)

question3 <- function(oldVector, theta=0)
{
  oldMatrix <- matrix(data = oldVector, nrow = 2, ncol = 1, byrow = FALSE)#Convert vector to 2x1 matrix
  rotationMatrixData <- c(cos(theta), -sin(theta), sin(theta), cos(theta))#The data for the matrix to rotate the oldMatrix
  rotationMatrix <- matrix(data = rotationMatrixData , nrow = 2, ncol = 2, byrow = TRUE)#The matrix to rotate the oldMatrix
  return(c(rotationMatrix %*% oldMatrix))#Premultiply the oldMatrix by the rotationMatrix and convert to vector
}
oldVector <- c(5,3)#The (x,y) vector to be rotated
theta <- pi/2#The amount to rotate the vector, in radians
question3(oldVector, theta)

question4 <- function(x)
{
  minDatum <- x[1]#The first value, initial min value
  for (aDatum in x)#Progresses through each value in vector
    if (aDatum < minDatum)#Check to see if value is less than current minimum
      minDatum <- aDatum#If yes, assigns current value as new minimum
  return(minDatum)#Returns the minimum value
}

x <- c(7.4, 3.5, 9.5, 13.7, 2.3, 5.4, 6.5, -1.3, 5.2, 0.2, -0.4, -4.2, 5.3, 0, 11.2)#The vector to find the min of
question4(x)

question5 <- function()
{
  switches <- c(rep("Off", 100))
  for (person in 1:100)
  {
    for (switch in 1:100)
    {
      if (switch %% person == 0)
      {
        if (switches[switch] == "Off") {
          switches[switch] = "On"
        } else {
          switches[switch] = "Off"
        }
      }
    }
  }
  return(switches)
}
question5()